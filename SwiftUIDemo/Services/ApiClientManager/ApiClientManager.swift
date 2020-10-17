//
//  ApiClientManager.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation
import Moya
import Unbox
import Alamofire

class ApiClientManager {

    static let instance: ApiClientManager = ApiClientManager()

    let databaseManager: DatabaseManager = DatabaseManager.instance

    static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        return configuration
    }()
    
    let manager: Manager = {
        #if UAT_MODE
            let serverTrustPolicies: [String: ServerTrustPolicy] = [
                API_BASE_URL.host!: .disableEvaluation
            ]
            return Manager(
                configuration: configuration,
                serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
            )
        #else
            return Manager(configuration: configuration)
        #endif
        
    }()
    
    
    /// Request to API without return response
    ///
    /// - Parameters:
    ///   - targetType:
    ///   - target:
    ///   - tokenType:
    ///   - result:
    public func requestResponseDefault<T>(targetType: T.Type, target: T, tokenType: TokenType = .ClientToken, isShowError: Bool = true, result: @escaping (Data?, Int?) -> Void ) where T: TargetType {

        if !Connectivity.isConnectedToInternet() {
            if isShowError {
                //Common.showApiError(endPoint: target.path, error: nil, action: { (alertAction) in
                    self.requestResponseDefault(targetType: targetType, target: target, result: result)
                //})
            }
            result(nil, nil)
            return
        }
        self.getAccessToken(tokenType: tokenType) {[weak self] (accessToken) in
            if let newAccessToken = accessToken {
                
                DispatchQueue(label: "app").async {
                    if let requestClosure = self?.makeRequestClosure(target: targetType, accessToken: newAccessToken){
                        let manager: Manager! = self?.manager
                        let provider = MoyaProvider<T>(requestClosure: requestClosure, manager: manager, plugins: [CompleteUrlLoggerPlugin()])
                        
                        Logger.log("Start _API_: \(target.path)")
                        provider.request(target, completion: {(responseObject) in
                            switch responseObject {
                            case .success(let response):
                                DispatchQueue.main.async {
                                    if response.statusCode != 200 {
                                        #if DEBUG
                                        Logger.log("Http Code: \(response.statusCode)  Stop _API_: \(target.path)")
                                        let responseStr = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments)
                                        Logger.log(responseStr ?? "")
                                        #endif
                                    }
                                    result(response.data, response.statusCode)
                                }
                                break
                            case .failure(let error):
                                Logger.log("Error _API_: \(target.path)")
                                DispatchQueue.main.async {
                                    Logger.log(error.localizedDescription)
                                    result(nil, nil)
                                }
                                break
                            }
                        })
                        
                    } else {
                        Logger.log("Can not create request Cloruse Api")
                        result(nil, nil)
                    }
                }
            } else {
                result(nil, nil)
            }
        }
    }
    
    
    /// Request to API with return response as single object
    ///
    /// - Parameters:
    ///   - targetType:
    ///   - target:
    ///   - returnType:
    ///   - tokenType:
    ///   - result:
    public func requestResponseSingle<T, U>(targetType: T.Type, target: T, returnType: U.Type?, tokenType: TokenType = .ClientToken, isShowError: Bool = true, result: @escaping (U?, Int?) -> Void ) where T: TargetType, U: Unboxable{
        self.requestResponseDefault(targetType: targetType, target: target, tokenType: tokenType, isShowError: isShowError) {[weak self] (data, statusCode) in
            if let data = data {
                let responseObject = self?.parseData(data: data, returnType: returnType, isReturnList: false) as? U
                DispatchQueue.main.async {
                    result(responseObject, statusCode)
                }
            } else {
                Logger.log("Api request data null \(target.path)")
                DispatchQueue.main.async {
                    result(nil, statusCode)
                }
            }
        }
        
    }
    
    
    /// Request to API with return response as multi object (List Object)
    ///
    /// - Parameters:
    ///   - targetType:
    ///   - target:
    ///   - returnType:
    ///   - tokenType:
    ///   - result:
    public func requestResponseMulti<T, U>(targetType: T.Type, target: T, returnType: U.Type?, tokenType: TokenType = .ClientToken, isShowError: Bool = true, result: @escaping ([U]?) -> Void ) where T: TargetType, U: Unboxable{
        
        self.requestResponseDefault(targetType: targetType, target: target, tokenType: tokenType, isShowError: isShowError) {[weak self] (data, statusCode) in
            if let data = data {
                let responseObject = self?.parseData(data: data, returnType: returnType, isReturnList: true) as? [U]
                DispatchQueue.main.async {
                    result(responseObject)
                }
            } else {
                Logger.log("Api request data null")
                DispatchQueue.main.async {
                    result(nil)
                }
            }
        }
    }
    
    private func makeRequestClosure<T: TargetType>(target: T.Type, accessToken: String?) -> MoyaProvider<T>.RequestClosure {
        
        let requestClosure = {(endPoint: Endpoint, done: @escaping MoyaProvider.RequestResultClosure) in
            do {
                if let accessToken = accessToken {
                    let _endPoint = endPoint.adding(newHTTPHeaderFields: ["Authorization" : "Bearer " + accessToken])
                    let request = try _endPoint.urlRequest()
                    
                    done(.success(request))
                } else {
                    let request = try endPoint.urlRequest()
                    done(.success(request))
                }
            }
            catch (let error){
                done(.failure(MoyaError.requestMapping(error.localizedDescription)))
            }
            
        }
        
        return requestClosure
    }
    
    public func parseData<T: Unboxable>(data: Data, returnType: T.Type?, isReturnList: Bool) -> Any?{
        
        do {
            #if DEBUG
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                Logger.log(response)
            #endif
            
            if isReturnList {
                return try unbox(data: data) as [T]
            } else {
                return try unbox(data: data) as T
            }
            
        }
        catch (let error) {
            Logger.log(error.localizedDescription, data)
            return nil
        }
        
    }

}

class CompleteUrlLoggerPlugin : PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        Logger.log(request.request?.url?.absoluteString ?? "Something is wrong")
    }
}
