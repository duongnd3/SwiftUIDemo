//
//  MainView.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import SwiftUI
import ShimmerView

struct MainView : View {
    var body: some View {
        SideMenu(leftMenu: LeftMenu(appState: AppState()),
                 centerView: HomeTabView())
            .environmentObject(ShimmerConfig())
    }
}

#if DEBUG
struct MainView_Previews : PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
