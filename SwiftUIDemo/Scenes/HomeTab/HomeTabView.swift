//
//  HomeTabView.swift
//  SwiftUIDemo
//
//  Created by グェン ディン ズォン on 2020/07/21.
//  Copyright © 2020 NDBlack. All rights reserved.
//

import SwiftUI
import SFSafeSymbols

struct HomeTabView: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.sideMenuLeftPanelKey) var sideMenuLeftPanel
    @Environment(\.sideMenuRightPanelKey) var sideMenuRightPanel
    
    var body: some View {
        NavigationView {
            containedView()
                .navigationBarTitle("Latest", displayMode: .inline)
                .navigationBarItems(
                    leading: Button(action: {
                        withAnimation {
                            self.sideMenuLeftPanel.wrappedValue = !self.sideMenuLeftPanel.wrappedValue
                        }
                    }, label: {
                        Image(systemName: SFSymbol.lineHorizontal3.rawValue)
                            .accentColor(.blue)
                            .imageScale(.large)
                    })
                )
        }.onAppear {
            self.fetchData()
        }
    }
    
    func containedView() -> AnyView {
        let view: AnyView
        view = AnyView(List {
            Text("No photos")
            Text("No photos")
        })
        
        return view
    }
    
    // MARK: - Private
    
    private func fetchData() {
        
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView().environmentObject(AppState())
    }
}
