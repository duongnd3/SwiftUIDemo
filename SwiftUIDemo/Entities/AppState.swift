//
//  AppState.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Combine

final class AppState: ObservableObject {
    @Published var isLogin = false
    @Published var userName = ""
    @Published var email = ""
}
