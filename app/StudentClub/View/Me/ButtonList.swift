//
//  ButtonList.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/14.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct ButtonList: View {
    @EnvironmentObject var store: Store
    
    @State var showList: Bool = false

    var showMe: Bool{
        self.store.appState.showMe
    }
    
    var body: some View{
        VStack {
            GeometryReader { proxy in
                VStack(spacing: 30){
                    VStack(spacing: 0) {
                        Button(action: {
                            self.store.appState.rightSliderPageState = .profile
                        }){
                            ButtonLabel(icon: "person.circle.fill", text: "名片")
                        }
                        
                        Button(action:{
                            self.store.appState.rightSliderPageState = .newsBase
                        }){
                            ButtonLabel(icon: "tray.full.fill", text: "新闻库")
                        }
                        Button(action:{
                            self.store.appState.rightSliderPageState = .blogBase
                        }){
                            ButtonLabel(icon: "book.circle.fill", text: "Blog")
                        }
                    }.frame(width: proxy.size.width, height: proxy.size.height*0.6)
                    
                    VStack() {
                        HStack{
                            Button(action:{
                                self.store.appState.meState.isClubInfoActive = true
                            }){
                                ButtonLabel(icon: "person.2.fill", text: "俱乐部")
                            }
                            .sheet(isPresented: self.$store.appState.meState.isClubInfoActive){
                                ClubInfoPage().environmentObject(self.store)
                            }
                            
                            Button(action:{
                                self.store.appState.meState.isClubListActive = true
                            }){
                                    HStack {
                                        Image(systemName: "person.2.square.stack.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20, alignment: .leading)
                                            .foregroundColor(Color.black.opacity(0.7))
                                            .padding(.horizontal, 10)
                                            .padding(.leading, 5)
                                    }
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                    .padding(.vertical, 12)
                                    .shadow(radius: 5)
                                    .frame(width: 55, alignment: .center)
                            }
                            .sheet(isPresented: self.$store.appState.meState.isClubListActive){
                                ClubListPage().environmentObject(self.store)
                            }
                        }
                    }.frame(width: proxy.size.width, height: proxy.size.height*0.2)
                    
                    VStack(){
                        Button(action: {
                            self.store.dispatch(.logout)
                        }){
                            Text("退出登录")
                                .font(.system(size: 18))
                                .fontWeight(.regular)
                                .foregroundColor(Color.red)
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                                .padding(.vertical)
                                .shadow(color: Color.red.opacity(0.1), radius: 5)
                                .shadow(radius: 5)
                        }
                    }.frame(width: proxy.size.width, height: proxy.size.height*0.2)
                        .padding(.top, 40)
                }
                .frame(width: self.showMe ? Globals.screen.width*0.9:0, height: self.showMe ? 500 : 0, alignment: .top)
            }
        }
        .frame(width: self.showMe ? Globals.screen.width*0.9 : 0, height: self.showMe ? Globals.screen.height * 0.6 : 0, alignment: .top)
    }
}

struct ButtonList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonList().environmentObject(Store())
//            ButtonList().environmentObject(Store()).previewDevice("iPhone 8")
        }
        
    }
}

struct ButtonLabel: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: self.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20, alignment: .leading)
                .foregroundColor(Color.black.opacity(0.7))
                .padding(.horizontal, 10)
                .padding(.leading, 5)
            
            Text(self.text)
                .font(.system(size: 16))
                .fontWeight(.regular)
                .foregroundColor(Color.black.opacity(0.6))
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
        .padding(.vertical, 12)
        .shadow(radius: 5)
    }
}
