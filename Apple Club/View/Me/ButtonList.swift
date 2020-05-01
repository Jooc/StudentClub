//
//  ButtonList.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/14.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct ButtonList: View {
    @EnvironmentObject var store: Store
    @State var show = false
    
    var showMe: Bool{
        self.store.appState.showMe
    }
    
    var body: some View{
        ZStack {
            VStack {
                GeometryReader { proxy in
                    VStack(spacing: 30){
                        VStack(spacing: 0) {
                            Button(action:{}){
                                ButtonLabel(icon: "person.circle.fill", text: "名片")
                            }
                            Button(action: {}){
                                ButtonLabel(icon: "tray.full.fill", text: "新闻库")
                            }
                            Button(action: {}){
                                ButtonLabel(icon: "book.circle.fill", text: "Blog")
                            }
                        }.frame(width: proxy.size.width, height: proxy.size.height*0.6)
                        
                        VStack(spacing: 20) {
                            HStack{
                                Button(action:{}){
                                    ButtonLabel(icon: "person.2.fill", text: "俱乐部")
                                }
                                Button(action:{}){
                                    ButtonLabel(icon:"person.2.square.stack.fill", text: "")
                                        .frame(width: 70)
                                }
                            }
                        }.frame(width: proxy.size.width, height: proxy.size.height*0.2)
                        
                        VStack(){
                            Button(action: {
                                self.store.dispatch(.logout)
                            }){
                                Text("退出登录")
                                    .font(.system(size: 20))
                                    .fontWeight(.regular)
                                    .foregroundColor(Color.red)
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    .background(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    .padding(.vertical)
                                    .shadow(color: Color.red.opacity(0.1), radius: 5)
                                    .shadow(radius: 5)
                            }
                        }.frame(width: proxy.size.width, height: proxy.size.height*0.2)
                    }
                    .frame(width: self.showMe ? screen.width*0.9:0, height: self.showMe ? 500 : 0, alignment: .top)
                }
            }
            .frame(width: self.showMe ? screen.width*0.9 : 0, height: self.showMe ? screen.height * 0.6 : 0, alignment: .top)
            
//            Button(action:{
//                self.store.appState.showMe.toggle()
//            }){
//                Text("Button")
//                .frame(width: 150, height: 70)
//                    .background(Color("Base"))
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//            }
        }
    }
}

struct ButtonList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ButtonList().environmentObject(Store())
            ButtonList().environmentObject(Store()).previewDevice("iPhone 8")
        }

    }
}

struct ButtonLabel: View {
    var icon: String
    var text: String
    
    var body: some View {
            HStack {
                Image(systemName: self.icon)
                    .foregroundColor(Color.black.opacity(0.7))
                    .font(.system(size: 22))
                    .padding()
                    .padding(.leading, 10)
                
                Text(self.text)
                    .font(.system(size: 22))
                    .fontWeight(.regular)
                    .foregroundColor(Color.black.opacity(0.6))
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .leading)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(.vertical)
            .shadow(radius: 5)
        }
}
