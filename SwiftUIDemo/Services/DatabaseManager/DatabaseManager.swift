//
//  DatabaseManager.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation
import RealmSwift

class DatabaseManager {
    
    static let instance = DatabaseManager()
    public let userDA: UserDA
    
    var config: Realm.Configuration!
    
    init() {
        config = Realm.Configuration(
            schemaVersion: 5
        )
        
        self.userDA = UserDA(config: config)
        
        if let realmUrl = Realm.Configuration.defaultConfiguration.fileURL {
            Logger.log("Realm URL: " + realmUrl.absoluteString)
        }
    }
}
