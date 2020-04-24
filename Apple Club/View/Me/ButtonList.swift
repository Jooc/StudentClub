//
//  ButtonList.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/14.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct ButtonList: View {
    @State var show = false
    
    var body: some View{
        VStack(spacing: 60){
            VStack(spacing: 20) {
                Button(action: {self.show.toggle()}){
                    ButtonLabel(icon: "person.circle.fill", text: "名片")
                }
                .sheet(isPresented: $show){
                    Text("123123123")
                        .onTapGesture {
                            self.show.toggle()
                    }
                }
                
                Button(action: {}){
                    ButtonLabel(icon: "tray.full.fill", text: "新闻库")
                }
                Button(action: {}){
                    ButtonLabel(icon: "book.circle.fill", text: "Blog")
                }
            }
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
            }
            VStack(){
                Button(action: {}){
                    Text("退出登录")
                        .font(.system(size: 20))
                        .fontWeight(.regular)
                        .foregroundColor(Color.red)
                        .frame(height: 70)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.red.opacity(0.1), radius: 5)
                        .shadow(radius: 5)
                        .padding(.top, 100)
                }
            }
        }
        .frame(width: screen.width*0.9, height: 500, alignment: .top)
        .padding()
        .padding(.top, 40)
    }
}

struct ButtonList_Previews: PreviewProvider {
    static var previews: some View {
        ButtonList()
    }
}

struct ButtonLabel: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color.black.opacity(0.7))
                .font(.system(size: 22))
                .padding()
                .padding(.leading, 10)
            
            Text(text)
                .font(.system(size: 22))
                .fontWeight(.regular)
                .foregroundColor(Color.black.opacity(0.6))
        }
        .frame(height: 70)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(radius: 5)
    }
}
