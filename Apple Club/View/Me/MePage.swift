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
    
    @State var closed = true
    @State var opened = false
    @State  var dragPosition = CGSize.zero
    
    @EnvironmentObject var store: Store
    var viewModel: MeViewModel
    
    var body: some View {
        ZStack() {
            Color("Base")
                .edgesIgnoringSafeArea(.all)
            
            ButtonList()
                .offset(y: 550)
                .offset(y: self.closed ? 195 : 0)
                .offset(y: self.opened ? -580 : 0)
                .offset(y: self.dragPosition.height*0.5)
            
            profile
                .offset(y: -200)
                .offset(y: self.closed ? 195 : 0)
                .offset(y: self.opened ? -580 : 0)
                .offset(y: self.dragPosition.height)

            avatar
                .offset(y: 60)
                .offset(y: self.closed ? 195 : 0)
                .offset(y: self.opened ? -400 : 0)
                .offset(y: self.dragPosition.height)
            
        }
        .animation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 2))
        .gesture(
            DragGesture().onChanged(){ value in
                self.dragPosition = value.translation
            }
            .onEnded(){ value in
                if value.translation.height < -300{
                    self.opened = true
                    self.closed = false
                }
                else if value.translation.height > 200{
                    self.opened = false
                    self.closed = true
                }
                else{
                    self.opened = false
                    self.closed = false
                }
                self.dragPosition = .zero
            }
        )
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
                   Text(viewModel.user.username)
                       .offset(y:70)
        }
    }
    
    var profile: some View{
        VStack{
            ZStack {
                //KFImage(URL(string: me.avatar))
                Image(uiImage: #imageLiteral(resourceName: "back-1"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screen.width, height: screen.height)
                    .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    .shadow(radius: 10, x: 0, y: 5)
//                    .offset(y: self.closed ? 0 : -screen.height*0.3)
            }
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

