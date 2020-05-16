//
//  MePage.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/9.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct MePage: View {
    @EnvironmentObject var store: Store
    
    var closed: Bool{
        self.store.appState.meState.closed
    }
    //    @State var closed = false
    
    var dragPosition: CGSize{
        self.store.appState.calendarState.calendarViewModel.dragPosition
    }
    
    var showMe: Bool{
        self.store.appState.showMe
    }
    
    var user: User?{
        self.store.appState.loginState.user
    }
    
    var body: some View {
        ZStack {
            ZStack {
                Color("Base")
                    .edgesIgnoringSafeArea(.all)
                
                ButtonList()
                    .offset(y: -20)
                    .offset(y: self.closed ? 195 : 0)
                    .offset(y: self.showMe ? 0 : -300)
                    .animation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0))

                profile
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: -Globals.screen.height*0.9)
                    .offset(y: self.closed ? Globals.screen.height*0.9 : 0)
                    .offset(y: self.closed ? min(0, self.dragPosition.height) : self.dragPosition.height)
                    .animation(.spring(response: 0.55, dampingFraction: 0.9, blendDuration: 10))
                    .gesture(
                        DragGesture().onChanged(){ value in
                            // TODO: Maybe a better place for dragPosition
                            self.store.appState.calendarState.calendarViewModel.dragPosition = value.translation
                        }
                        .onEnded(){ value in
                            if value.predictedEndTranslation.height < -300{
                                self.store.appState.meState.closed = false
                            }
                            if value.predictedEndTranslation.height > 200{
                                self.store.appState.meState.closed = true
                            }
                            self.store.appState.calendarState.calendarViewModel.dragPosition = .zero
                    })
            }
            .scaleEffect(self.showMe ? 1 : 0)
            .offset(y: self.showMe ? 0 : 1000)
            
            avatar
                .offset(y: 250)
                .offset(y: self.showMe ? self.closed ? -50 : -Globals.screen.height*0.85 : 0)
                .offset(y: self.store.appState.calendarState.calendarViewModel.dragPosition.height/2)
                .animation(.spring())
        }
    }
    
    var profile: some View{
        GeometryReader { proxy in
            Image(uiImage: #imageLiteral(resourceName: "back-1"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipShape(RoundedRectangle(cornerRadius: self.closed ? 0 : 30, style: .continuous))
                .shadow(radius: 10, x: 0, y: 5)
        }
    }
    
    var avatar: some View{
        GeometryReader { proxy in
            ZStack(alignment: .center) {
                Circle()
                    .frame(width: proxy.size.width, height: proxy.size.height)
                    .foregroundColor(Color.white)
                    .shadow(radius: 10)
                if self.user != nil{
                    KFImage(URL(string: Globals.OSSPrefix+self.user!.avatar) ?? Globals.defaultAvatarURL)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: proxy.size.width*0.92, height: proxy.size.height*0.92)
                        .clipShape(Circle())
                }
            }
//            .onTapGesture {
//                if self.store.appState.meState.closed{
//                    self.store.appState.showMe.toggle()
//                }
//            }
        }.frame(width: self.store.appState.showMe ? 90 : 75, height: self.store.appState.showMe ? 90 : 75)
    }
}

struct MePage_Previews: PreviewProvider {
    static var previews: some View {
        MePage().environmentObject(Store.Sample())
    }
}

