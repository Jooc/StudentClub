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
    
    var image: Image?{
        self.store.appState.postState.image
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                
                tableView
                
                MePage(viewModel: MeViewModel.Sample())
                    .animation(.spring(response: 0.1))
                
                if store.appState.postListState.detailedNews != nil{
                    NewsDetail(viewModel: self.store.appState.postListState.detailedNews!, show: self.$store.appState.showDetailedNews)
                }
                
                if store.appState.user == nil{
                    LoginPage()
                }
            }
        }
    }
    
    var tableView: some View{
        TabView{
            NewsPage()
                .tabItem{
                    VStack {
                        Image(systemName: "message.fill")
                        Text("News")
                    }.padding(.trailing, 50)
            }
            
            CalendarPage()
                .tabItem{
                    VStack {
                        Image(systemName: "calendar")
                        Text("Activity")
                    }
            }
        }
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainTab().environmentObject(Store.Sample())
            //            MainTab().environmentObject(Store.Sample()).previewDevice("iPhone 8")
        }
    }
}
