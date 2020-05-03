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

    var showAddButtons: Bool{
        self.store.appState.newsState.showAddButtons
    }
    
    var pickImageActionSheet: Binding<Bool>{
        self.$store.appState.newsState.pickImageActionSheet
    }
    
    var closed: Bool{
        self.store.appState.closed
    }
    
    var dragPosition: CGSize{
        self.store.appState.calendarState.calendarViewModel.dragPosition
    }
    
    var showMe: Bool{
        self.store.appState.showMe
    }
    
    @State var showCamera = false
    @State var showPhotoLibrary = false
    @State var image: Image?
    
    @State var showPostNewsPage = false
    @State var showDetailedNews = false
    

    
    var body: some View {
        ZStack {
            ZStack() {
                tableView

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
                
                if self.showCamera{
                    ImagerPickeView(isShown: $showCamera, image: $image, sourceType: .camera)
                        .edgesIgnoringSafeArea(.all)
                        .onDisappear(){ self.showPostNewsPage = true }
                }
                
                if self.showPhotoLibrary{
                    ImagerPickeView(isShown: $showPhotoLibrary, image: $image, sourceType: .photoLibrary)
                        .edgesIgnoringSafeArea(.all)
                        .onDisappear(){ self.showPostNewsPage = true }
                }
                
                if self.showPostNewsPage{
                    PostNewsPage()
                }
            }
            .actionSheet(isPresented: pickImageActionSheet){
                ActionSheet(title: Text("Photos"), buttons: [
                    ActionSheet.Button.default(Text("Camera")){
                        self.showCamera = true
                    },
                    ActionSheet.Button.default(Text("Choose from Album")){
                        self.showPhotoLibrary = true
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
