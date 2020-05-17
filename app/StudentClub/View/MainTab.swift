//
//  MainTab.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/10.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct MainTab: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
            ZStack {
                
                tableView
                
                UpSlider()
                    .offset(x:0, y: self.store.appState.upSliderPageState == .NONE ?  -Globals.screen.height*2 : 0)
                    .animation(.spring())
                
                if store.appState.postListState.detailedNews != nil{
                    NewsDetail(viewModel: self.store.appState.postListState.detailedNews!, show: self.$store.appState.showDetailedNews)
                }
                
                if store.appState.loginState.user == nil{
                    LoginPage()
                }
            }
    }
    
    var tableView: some View{
        TabView{
            NewsPage()
                .navigationBarTitle("Post")
                .navigationBarHidden(true)
                .tabItem{
                    VStack {
                        Image(systemName: "message.fill")
                        Text("Post")
                    }.padding(.trailing, 50)
            }

            CalendarPage()
                .navigationBarTitle("Activity")
                .navigationBarHidden(true)
                .tabItem{
                    VStack {
                        Image(systemName: "calendar")
                        Text("Activity")
                    }
            }
            
            MePage()
                .navigationBarTitle("Profile")
                .navigationBarHidden(true)
                .tabItem{
                    VStack{
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
        }
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab().environmentObject(Store())
            //            MainTab().environmentObject(Store.Sample()).previewDevice("iPhone 8")
    }
}
