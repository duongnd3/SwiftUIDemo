//
//  LeftMenuInteractor.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation

final class LeftMenuInteractor {

    func fetchEventData(complete: @escaping ([ServiceModel]?)->()){
        ServiceManager.instance.getServices { (services) in
            if let services = services {
                complete(services)
            } else {
                complete(nil)
            }
        }
    }
}
