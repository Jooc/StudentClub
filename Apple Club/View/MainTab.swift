//
//  MainTab.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/10.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct MainTab: View {
    @EnvironmentObject var store: Store
    @State var showMe = false
    
    var body: some View {
        ZStack {
            TabView{
                NewsPage().tabItem{
                    Image(systemName: "message.fill")
                    Text("News")
                }
                CalendarPage().tabItem{
                    Image(systemName: "calendar")
                    Text("Activity")
                }
            }.edgesIgnoringSafeArea(.top)
            
            if store.appState.loginState.showLoginPage{
                LoginPage()
            }
        }
        
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab().environmentObject(Store.Sample())
    }
}
