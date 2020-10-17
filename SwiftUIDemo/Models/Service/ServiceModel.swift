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

class ServiceResponse: Unboxable {
    var serviceModel: [ServiceModel]?
    var code: Int?
    var status: Bool
    var message: String = ""
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    
    required init(unboxer: Unboxer) throws {
        self.serviceModel = try? unboxer.unbox(key: "results")
        self.code = try? unboxer.unbox(key: "code")
        self.status = (try? unboxer.unbox(key: "code")) ?? false
        self.message = (try? unboxer.unbox(key: "code")) ?? ""
        self.offset = try? unboxer.unbox(key: "offset")
        self.limit = try? unboxer.unbox(key: "limit")
        self.total = try? unboxer.unbox(key: "total")
        self.count = try? unboxer.unbox(key: "count")
    }
}

class ServiceModel: Object, Unboxable {
    @objc dynamic var serviceId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var serviceDescription: String = ""
    
    override static func primaryKey() -> String {
        return "serviceId"
    }
    
    required init(unboxer: Unboxer) throws {
        super.init()
        self.serviceId = (try? unboxer.unbox(key: "id")) ?? ""
        self.name = (try? unboxer.unbox(key: "name")) ?? ""
        self.serviceDescription = (try? unboxer.unbox(key: "description")) ?? ""
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
