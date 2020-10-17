//
//  LeftMenu.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import SwiftUI

internal struct LeftMenu: View {
    @Environment(\.sideMenuGestureModeKey) var sideMenuGestureMode
    @Environment(\.sideMenuLeftPanelKey) var sideMenuLeftPanel
    @Environment(\.sideMenuCenterViewKey) var sideMenuCenterView

    @ObservedObject var presenter:  LeftMenuPresenter
    init(appState: AppState) {
        self.presenter = LeftMenuPresenter(appState: appState)
    }
    
    var body: some View {
        
        return GeometryReader { geometry in
            
            List(self.presenter.services, id: \.serviceId) { service in
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Button(action: {
                        withAnimation {
                            self.sideMenuLeftPanel.wrappedValue = false
                        }
                    }, label: {
                        Text(service.name)
                    })
                }
                .padding()
                .frame(maxWidth: geometry.size.width, alignment: .leading)
                .edgesIgnoringSafeArea(.all)
            }
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .padding(.top, 200)
            .background(Color.white)
        }
    }
}

#if DEBUG
struct LeftMenu_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            LeftMenu(appState: AppState())
        }
    }
}
#endif
