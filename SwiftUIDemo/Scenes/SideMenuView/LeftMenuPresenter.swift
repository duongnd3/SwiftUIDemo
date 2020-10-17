//
//  LeftMenuPresenter.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import Foundation

final class LeftMenuPresenter: ObservableObject {

    @Published var services: [ServiceModel] = []
    
    init(appState: AppState) {
        self.appState = appState
        interactor.fetchEventData { (services) in
            if let services = services {
                self.services = services
            }
        }
    }
    
    // Private
    private let appState: AppState
    private let interactor = LeftMenuInteractor()
}
