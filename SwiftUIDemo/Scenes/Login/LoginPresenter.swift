//
//  LoginPresenter.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import SwiftUI
import Combine

final class LoginPresenter: ObservableObject {
    enum Inputs {
        case didTapLoginButton
    }
    
    init(appState: AppState) {
        self.appState = appState
    }
    
    func apply(inputs: Inputs) {
        switch inputs {
            case .didTapLoginButton:
                appState.isLogin = true
        }
    }
    
    func didTapLoginButton(email: String, password: String) {
        Logger.log("\(email) - \(password)")
        var params: [String: Any] = [String: Any]()
        params["email"] = email
        params["password"] = password
        self.interactor.userLogin(parameters: params) { (userModel) in
            if let userModel = userModel {
                self.appState.isLogin = true
                self.appState.email = userModel.email
                self.appState.userName = userModel.name
            }
        }
    }
    
    // Private
    private let appState: AppState
    private let interactor = LoginInteractor()
}
