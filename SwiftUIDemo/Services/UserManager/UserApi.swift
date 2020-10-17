//
//  UserApi.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation
import Moya
import UIKit

enum UserApi {
    case userLogin([String: Any]?)
}

extension UserApi: TargetType {
    var baseURL : URL { return API_BASE_URL}
    
    var path: String {
        switch self {
        case .userLogin:
            return "/api/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .userLogin:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .userLogin(let parameters):
            if let parameters = parameters {
                Logger.log("\(parameters)")
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            }
            return .requestPlain
        default:
            return .requestPlain
        }
    }
        
    var headers: [String : String]? {
        return
            ["Accept":"application/json",
             "Content-Type":"application/json"]
    }
    
    var validationType: ValidationType {
        return .none
//        return .successCodes
    }
}
