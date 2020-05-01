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
    //    @State var showMe = false
    
//    @State var showAddPage = false
    var showAddButtons: Bool{
        self.store.appState.newsState.showAddButtons
    }
    var pickImageActionSheet: Binding<Bool>{
        self.$store.appState.newsState.pickImageActionSheet
    }
    
    @State var expand1 = false
    @State var expand2 = false
    
    @State var showDetailedNews = false
    
    var closed: Bool{
        self.store.appState.closed
    }
    
    var dragPosition: CGSize{
        self.store.appState.dragPosition
    }
    
    var showMe: Bool{
        self.store.appState.showMe
    }
    
    var body: some View {
        ZStack {
            ZStack() {
                ZStack {
                    tableView
                    PostButton()
                }
                
                
                if self.showMe{
                    MePage(viewModel: MeViewModel.Sample())
                        .animation(.spring())
                }
                
                avatar
                    .offset(y: screen.height*0.42)
                    .offset(y: self.showMe ? self.closed ? -50 : -screen.height*0.8 : 0)
                    .offset(y: self.dragPosition.height/2)
                    .animation(.spring())
                
                if store.appState.newsState.detailedNews != nil{
                    NewsDetail(viewModel: self.store.appState.newsState.detailedNews!, show: $showDetailedNews)
                }
                
                if store.appState.user == nil{
                    LoginPage()
                }
            }
            .actionSheet(isPresented: pickImageActionSheet){
                ActionSheet(title: Text("Photos"), buttons: [
                    ActionSheet.Button.default(Text("Camera")){
                        
                    },
                    ActionSheet.Button.default(Text("Choose from Album")){
                        
                    },
                    ActionSheet.Button.cancel()
                ])
            }
        }
    }
    
    var tableView: some View{
        TabView{
            NewsPage().tabItem{
                VStack {
                    Image(systemName: "message.fill")
                    Text("News")
                }
            }
            CalendarPage().tabItem{
                VStack {
                    Image(systemName: "calendar")
                    Text("Activity")
                }
            }
        }
    }
    
    var avatar: some View{
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .foregroundColor(Color.white)
                    .shadow(radius: 10)
                Image(uiImage: #imageLiteral(resourceName: "avatar-1"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: proxy.size.width*0.90, height: proxy.size.height*0.90)
                    .clipShape(Circle())
                    .onTapGesture {
                        if self.closed{
                            self.store.appState.showMe.toggle()
                        }
                }
            }
        }.frame(width: self.showMe ? 110 : 85, height: self.showMe ? 110 : 85)
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


//            VStack{
//                Text("123")
//            }
//            .frame(width: self.expand1 ? screen.width : 200, height: self.expand1 ? screen.height : 100)
//            .background(Color("Logo_green"))
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .onTapGesture {
//                self.expand1.toggle()
//            }
//            .shadow(color: Color("Base"), radius: 20, x: 0, y: 0)
//            .offset(x: self.showAddPage ? 0 : 400, y: self.expand1 ? 0 : -100)
//            .animation(.spring(response: 0.60, dampingFraction: 1, blendDuration: 0))
//
//            VStack{
//                Text("123")
//            }
//            .frame(width: 200, height: 100)
//            .onTapGesture {
//                self.expand1 = true
//            }
//            .frame(width: self.expand2 ? screen.width : 200, height: self.expand2 ? screen.height : 100)
//            .background(Color("Logo_purple"))
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .onTapGesture {
//                self.expand2.toggle()
//            }
//            .shadow(color: Color("Base"), radius: 20, x: 0, y: 0)
//            .offset(x: self.showAddPage ? 0 : 400, y: self.expand2 ? 0 : 100)
//            .animation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0))
