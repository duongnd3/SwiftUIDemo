//
//  Token.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import Unbox

enum TokenType: Int {
    case AppToken = 0 // Not login
    case ClientToken = 1 // Logined
}
