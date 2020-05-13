//
//  ShadowlyButton.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/29.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct ShadowlyButton: View {
    var icon: String
    
    @State var tap = false
    @State var press = false
    
    var body: some View {
        VStack(alignment: .center) {
            Image(systemName: icon)
                .font(.system(size: 25, weight: .light))
                .foregroundColor(Color.black)
                .rotationEffect(Angle(degrees: press ? 135 : 0), anchor: .center)
        }
        .frame(width: 50, height: 50)
        .background(
            ZStack {
                LinearGradient(gradient: Gradient(colors: [press ? Color.white : Color("Base"), press ? Color("Base") : Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                Circle()
                    .stroke(Color.clear, lineWidth: 10) 
                    .shadow(color: press ? Color.white : Color("Base-deeper"), radius: 3, x: -5, y: -5)
                Circle()
                    .stroke(Color.clear, lineWidth: 10)
                    .shadow(color: press ? Color("Base-deeper") : Color.white, radius: 3, x: 3, y: 3)
        })
            .clipShape(Circle())
            .shadow(color: press ? Color("Base-deeper") : Color.white, radius: 20, x: -20, y: -20)
            .shadow(color: press ? Color.white : Color("Base-deeper"), radius: 20, x: 20, y: 20)
            .scaleEffect(press ? 0.9 : 1)
            .gesture(
                TapGesture()
                    .onEnded{ value in
                        self.press.toggle()
                        print(self.press)
            })
            .animation(.spring())
    }
}

struct ShadowlyButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("Base").edgesIgnoringSafeArea(.all)
            ShadowlyButton(icon: "plus")
        }
    }
}
