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
    
    var pickImageActionSheet: Binding<Bool>{
        self.$store.appState.newsState.pickImageActionSheet
    }
    
    var body: some View {
        ZStack {
            ZStack() {
                tableView

                if self.store.appState.showMe{
                    MePage(viewModel: MeViewModel.Sample())
                        .animation(.spring())
                }
                
                avatar
                    .offset(y: screen.height*0.42)
                    .offset(y: self.store.appState.showMe ? self.store.appState.meState.closed ? -50 : -screen.height*0.8 : 0)
                    .offset(y: self.store.appState.calendarState.calendarViewModel.dragPosition.height/2)
                    .animation(.spring())
                
                if store.appState.newsState.detailedNews != nil{
                    NewsDetail(viewModel: self.store.appState.newsState.detailedNews!, show: self.$store.appState.showDetailedNews)
                }
                
                if store.appState.user == nil{
                    LoginPage()
                }
                
                if self.store.appState.showCamera{
                    ImagerPickeView(isShown: self.$store.appState.showCamera, image: self.$store.appState.image, sourceType: .camera)
                        .edgesIgnoringSafeArea(.all)
                        .onDisappear(){ self.store.appState.showPostNewsPage = true }
                }
                
                if self.store.appState.showPhotoLibrary{
                    ImagerPickeView(isShown: self.$store.appState.showPhotoLibrary, image: self.$store.appState.image, sourceType: .photoLibrary)
                        .edgesIgnoringSafeArea(.all)
                        .onDisappear(){ self.store.appState.showPostNewsPage = true }
                }
                
                if self.store.appState.showPostNewsPage{
                    PostNewsPage()
                }
            }
            .actionSheet(isPresented: pickImageActionSheet){
                ActionSheet(title: Text("Photos"), buttons: [
                    ActionSheet.Button.default(Text("Camera")){
                        self.store.appState.showCamera = true
                    },
                    ActionSheet.Button.default(Text("Choose from Album")){
                        self.store.appState.showPhotoLibrary = true
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
                        if self.store.appState.meState.closed{
                            self.store.appState.showMe.toggle()
                        }
                }
            }
        }.frame(width: self.store.appState.showMe ? 110 : 85, height: self.store.appState.showMe ? 110 : 85)
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
