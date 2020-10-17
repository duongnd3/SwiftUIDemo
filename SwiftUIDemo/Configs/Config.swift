//
//  Config.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation

public enum Config {

    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()
    
    /// API Config
    static let apiHost: URL = {
        guard let value = Config.infoDictionary["APP_API_HOST"] as? String else {
            fatalError("APP_API_HOST not set in plist for this environment")
        }
        return URL(string: value)!
    }()
}

var API_BASE_URL: URL {
    get {
        return Config.apiHost
    }
}
