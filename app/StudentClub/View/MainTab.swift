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
    
    var showBottomMenu: Bool{
        self.store.appState.detailsState.detailedUserID != nil
    }
    
    var body: some View {
            ZStack {
                
                tableView
                
                UpSlider()
                    .offset(x:0, y: self.store.appState.upSliderPageState == .NONE ?  -Globals.screen.height : 0)
                    .animation(.spring())
                
                RightSlider()
                    .offset(x: self.store.appState.rightSliderPageState == .NONE ?  Globals.screen.width : 0)
                    .animation(.spring())
                
                NewsDetailSlider()
                    .offset(y: self.store.appState.detailedNews == nil ? -Globals.screen.height : 0)
                    .animation(.spring())
                
                if store.appState.loginState.user == nil{
                    LoginPage()
                }
//                
//                if self.showBottomMenu{
//                    BottomMenu()
//                }
                
                
            }
            .alert(item: self.$store.appState.loginState.loginError){error in
                Alert(title: Text(error.localizedDescription))
        }
    }
    
    var tableView: some View{
        VStack {
            TabView{
                NewsPage(store: self.store)
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
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab().environmentObject(Store())
            //            MainTab().environmentObject(Store.Sample()).previewDevice("iPhone 8")
    }
}
