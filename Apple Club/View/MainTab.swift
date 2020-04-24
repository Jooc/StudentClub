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
                MePage(viewModel: MeViewModel.Sample()).tabItem{
                    Image(systemName: "person.circle")
                    Text("Me")
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
        Group {
            MainTab().environmentObject(Store.Sample())
            MainTab().environmentObject(Store.Sample()).previewDevice("iPhone 8")
        }
    }
}
