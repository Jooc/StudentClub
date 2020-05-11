//
//  PostButton.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/30.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct PostButton: View {
    @EnvironmentObject var store: Store

    var showAddButtons: Bool{
        self.store.appState.postListState.showAddButtons
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                ZStack(alignment: .topTrailing) {
                    HStack {
                        Button(action:{
                            
                        }){
                            VStack {
                                Image(systemName: "calendar.badge.plus")
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundColor(Color.black)
                            }
                            .frame(width: 30, height: 30)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color("Base-deeper"), radius: 5, x: 5, y: 5)
                        }
                        .offset(y: 20)
                    }
                    .frame(width: 90, alignment: .leading)
                    .rotationEffect(Angle(degrees: self.showAddButtons ? 0 : 90), anchor: .topTrailing)
                    .scaleEffect(self.showAddButtons ? 1 : 0)
                    .animation(.spring(response: 0.35, dampingFraction: 0.825, blendDuration: 0))
                    
                    VStack {
                        NavigationLink(
                            destination: PostNewsPage()
                                .navigationBarTitle("")
                                .navigationBarHidden(true),
                            isActive: self.$store.appState.showPostNewsPage)
                        {
                            VStack {
                                Image(systemName: "text.badge.plus")
                                    .font(.system(size: 15, weight: .light))
                                    .foregroundColor(Color.black)
                            }
                            .frame(width: 30, height: 30)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: Color("Base-deeper"), radius: 10, x: 5, y: -5)
                        }.offset(x: -20)
                    }
                    .frame(height: 90, alignment: .bottom)
                    .rotationEffect(Angle(degrees: self.showAddButtons ? 0 : 180), anchor: .top)
                    .scaleEffect(self.showAddButtons ? 1 : 0)
                    .animation(.spring(response: 0.45, dampingFraction: 0.825, blendDuration: 0))
                    
                    postButton
                }.padding(.trailing)
            }
            Spacer()
        }
    }
    
    var postButton: some View{
            VStack(alignment: .center) {
                Image(systemName: "plus")
                    .font(.system(size: 25, weight: .light))
                    .foregroundColor(Color.black)
                    .rotationEffect(Angle(degrees: self.showAddButtons ? -135 : 0), anchor: .center)
            }
            .frame(width: 50, height: 50)
            .background(
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [self.showAddButtons ? Color.white : Color("Base"), self.showAddButtons ? Color("Base") : Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    Circle()
                        .stroke(Color.clear, lineWidth: 10)
                        .shadow(color: self.showAddButtons ? Color.white : Color("Base-deeper"), radius: 3, x: -5, y: -5)
                    Circle()
                        .stroke(Color.clear, lineWidth: 10)
                        .shadow(color: self.showAddButtons ? Color("Base-deeper") : Color.white, radius: 3, x: 3, y: 3)
            })
                .clipShape(Circle())
                .shadow(color: self.showAddButtons ? Color("Base-deeper") : Color.white, radius: 20, x: -20, y: -20)
                .shadow(color: self.showAddButtons ? Color.white : Color("Base-deeper"), radius: 20, x: 20, y: 20)
                .scaleEffect(self.showAddButtons ? 0.9 : 1)
                .gesture(
                    TapGesture()
                        .onEnded{ value in
                            self.store.appState.postListState.showAddButtons.toggle()
                })
                .animation(.spring(response: 0.65, dampingFraction: 0.825, blendDuration: 0))
    }
}

struct PostButton_Previews: PreviewProvider {
    static var previews: some View {
            ZStack {
                Color("Base").edgesIgnoringSafeArea(.all)
                PostButton().environmentObject(Store())
            }
    }
}
