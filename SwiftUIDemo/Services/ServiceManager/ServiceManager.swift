//
//  ServiceManager.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation
import Unbox
import Moya
import Alamofire

class ServiceManager: NSObject {
    static let instance = ServiceManager()

    func getServices(complete: @escaping ([ServiceModel]?)->()){
        ApiClientManager.instance.requestResponseSingle(targetType: ServiceApi.self, target: .getAllServices, returnType: ServiceResponse.self) { (serviceResponse, statusCode) in
            if let serviceResponse = serviceResponse, statusCode == 200,  serviceResponse.code == 200, serviceResponse.status {
                complete(serviceResponse.serviceModel)
            } else {
                complete(nil)
            }
        }
    }
}
