//
//  Logger.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import UIKit

public class Logger: NSObject {
    public class func log(_ message: Any..., file: String = #file, function: String = #function, line: Int = #line) {
//        return
        #if DEBUG
        if let filename = file.components(separatedBy: "/").last {
            NSLog("Debug:>>>[%@.%@:%ld] %@", filename, function, line, message)
        }
        #endif
    }
}
