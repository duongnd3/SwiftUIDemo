//
//  User.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation
import RealmSwift
import Realm
import Unbox

class UserResponse: Unboxable {
    var userModel: UserModel?
    required init(unboxer: Unboxer) throws {
        self.userModel = try? unboxer.unbox(key: "results")
    }
}

class UserModel: Object, Unboxable {
    @objc dynamic var userId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var token: String = ""
    
    override static func primaryKey() -> String {
        return "userId"
    }
    
    required init(unboxer: Unboxer) throws {
        super.init()
        self.userId = (try? unboxer.unbox(key: "id")) ?? ""
        self.name = (try? unboxer.unbox(key: "name")) ?? ""
        self.email = (try? unboxer.unbox(key: "email")) ?? ""
        self.token = (try? unboxer.unbox(key: "token")) ?? ""
    }
    
    required init() {
        super.init()
    }
    
    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }
    
    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }
}
