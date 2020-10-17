//
//  LoginView.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State var inputEmail: String = ""
    @State var inputPassword: String = ""
    @ObservedObject var presenter: LoginPresenter
    init(appState: AppState) {
        self.presenter = LoginPresenter(appState: appState)
    }
    var body: some View {
        ScrollView {
            Text("Login")
                .font(.largeTitle)
            VStack(alignment: .leading) {
                Text("Account Name")
                TextField("E-mail", text: $inputEmail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding()

            VStack(alignment: .leading) {
                Text("Password")
                SecureField("Password", text: $inputPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            }
            .padding()

            Button(action: {
                //self.presenter.didTapLoginButton(email: self.inputEmail, password: self.inputPassword)
                self.presenter.didTapLoginButton(email: "duongnd@skanderipro.com", password: "1234567")
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(height: 70)
                    .padding()
                        .foregroundColor(.green)
                    Text("Login")
                        .font(.title)
                        .foregroundColor(.white)
                }
            })
        }
        .padding(.top)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(appState: AppState())
    }
}
