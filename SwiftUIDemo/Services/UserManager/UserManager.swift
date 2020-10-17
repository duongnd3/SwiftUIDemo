//
//  UserManager.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation
import Moya
import Unbox

class UserManager: NSObject {

    static let instance = UserManager()
    
    let databaseManager: DatabaseManager = DatabaseManager.instance

    public func userLogin(parameters :[String: Any], complete: @escaping (UserModel?) -> Void){
        
        ApiClientManager.instance.requestResponseSingle(targetType: UserApi.self, target: .userLogin(parameters), returnType: UserResponse.self, tokenType: .AppToken) { [weak self](userResponse, statusCode) in
            guard let strongSelf = self else { return }
            
            if let userResponse = userResponse, let statusCode = statusCode, statusCode == 200 {
                strongSelf.databaseManager.userDA.saveCustomer(user: userResponse.userModel)
                complete(userResponse.userModel)
            } else {
                complete(nil)
            }
        }
    }
}
