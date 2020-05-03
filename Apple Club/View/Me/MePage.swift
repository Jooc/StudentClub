//
//  MePage.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/9.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
//import KingfisherSwiftUI

struct MePage: View {
    @EnvironmentObject var store: Store
    
    var closed: Bool{
        self.store.appState.meState.closed
    }
    
    var dragPosition: CGSize{
        self.store.appState.calendarState.calendarViewModel.dragPosition
    }
    
    var showMe: Bool{
        self.store.appState.showMe
    }
    
    var viewModel: MeViewModel
    
    var body: some View {
        ZStack {
            ZStack {
                Color("Base")
                    .edgesIgnoringSafeArea(.all)
                
                ButtonList()
                    .offset(y: 0)
                    .offset(y: self.closed ? 195 : 0)
                    .offset(y: self.showMe ? 0 : -300)
                    .animation(.spring(response: 0.55, dampingFraction: 0.825, blendDuration: 0))
                
                profile
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: -screen.height*0.85)
                    .offset(y: self.closed ? screen.height*0.85 : 0)
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
                        }
                )
            }
//            .frame(width: showMe ? screen.width : 0, height: showMe ? screen.height : 0)
//            .offset(y: self.showMe ? 0 : 310)
            
            
            //            avatar
            //                .offset(y: -340)
            //                .offset(y: self.closed ? 650 : 0)
            //                .offset(y: self.dragPosition.height/2)
            //                .animation(.spring())
        }
    }
    
    var avatar: some View{
        ZStack {
            Circle()
                .frame(width: 110, height: 110)
                .foregroundColor(Color.white)
                .shadow(radius: 10)
            Image(uiImage: #imageLiteral(resourceName: "avatar-1"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .onTapGesture {
                    self.store.appState.showMe.toggle()
            }
            //            Text(viewModel.user.userName)
            //                .offset(y:70)
        }
    }
    
    var profile: some View{
        GeometryReader { proxy in
            Image(uiImage: #imageLiteral(resourceName: "back-1"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(radius: 10, x: 0, y: 5)
        }
    }
}

struct MePage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MePage(viewModel: MeViewModel.Sample()).environmentObject(Store.Sample())
            //            MePage(viewModel: MeViewModel.Sample()).environmentObject(Store.Sample()).previewDevice("iPhone 8")
        }
    }
}

