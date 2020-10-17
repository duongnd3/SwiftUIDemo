//
//  UserDA.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation
import RealmSwift

class UserDA {
    private var config: Realm.Configuration
    
    init(config: Realm.Configuration) {
        self.config = config
        self.clearData()
    }

    func clearData() {
        guard let realm = try? Realm(configuration: config) else { return }
        let results = realm.objects(UserModel.self)
        if realm.isInWriteTransaction {
            realm.delete(results)
        } else {
            try! realm.write {
                realm.delete(results)
            }
        }
    }
    
    func getCurrentuser() -> UserModel? {
        return try! Realm(configuration: self.config).objects(UserModel.self).first
    }
    
    func saveCustomer(user: UserModel?){
        if let user = user {
            let realm = try! Realm(configuration: self.config)
            if realm.isInWriteTransaction {
                realm.add(user, update: .all)
            } else {
                try! realm.write {
                    realm.add(user, update: .all)
                }
            }
        }
    }
}
