//
//  LoginInteractor.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import SwiftUI

final class LoginInteractor {
    func userLogin(parameters :[String: Any], complete: @escaping (UserModel?) -> Void) {
        UserManager.instance.userLogin(parameters: parameters) { (userModel) in
            complete(userModel)
        }
    }
}
