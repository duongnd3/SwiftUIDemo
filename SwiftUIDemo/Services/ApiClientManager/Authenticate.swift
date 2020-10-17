//
//  Authenticate.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation
import JWT
import Moya
import Unbox

extension ApiClientManager {

    private var appToken: String {
        get {
            return ""
        }
    }
    
    private var clientToken: String {
        get {
            if let currentToken = self.databaseManager.userDA.getCurrentuser() {
                return currentToken.token
            }
            return ""
        }
    }
    
    public func getAccessToken(tokenType: TokenType, complete: @escaping (String?) -> Void) {
        switch tokenType {
            case .AppToken:
                Logger.log("appToken token: \(appToken)")
                complete(appToken)
                break
            case .ClientToken:
                Logger.log("appToken token: \(clientToken)")
                complete(clientToken)
        }
    }

}
