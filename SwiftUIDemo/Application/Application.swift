//
//  Application.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation

final class Application {
    static let instance = Application()
    
    let databaseManager: DatabaseManager
    
    private init(){
        self.databaseManager = DatabaseManager.instance
    }
}
