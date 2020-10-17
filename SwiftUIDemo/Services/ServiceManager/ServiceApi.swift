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

enum ServiceApi {
    case getAllServices
}

extension ServiceApi: TargetType {
    var baseURL : URL { return API_BASE_URL}
    
    var path: String {
        switch self {
        case .getAllServices:
            return "/api/services"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAllServices:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getAllServices:
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
