//
//  EditUserName.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/5/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct EditUserName: View {
    @EnvironmentObject var store: Store
    
    var user: User{
        self.store.appState.user ?? User.Sample()
    }
    
    @State var newName: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.gray.opacity(0.1)
            
            VStack(spacing: 20) {
                HStack{
                    Button(action:{
                        self.store.appState.meState.editUserName = false
                    }){
                        Text("取消")
                            .foregroundColor(Color.black)
                            .padding(.all, 5)
                    }
                    
                    Spacer()
                    Text("修改用户名")
                    Spacer()
                    
                    Button(action:{
                        if self.user.userName != self.newName {
                            
                        }
                    }){
                        Text("确认")
                            .foregroundColor(Color.white)
                            .padding(.all, 10)
                            .background(user.userName == newName ? Color.gray.opacity(0.5) : Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                
                TextField(user.userName, text: self.$newName)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    .background(Color.white)
            }
        }
    }
}

struct EditUserName_Previews: PreviewProvider {
    static var previews: some View {
        EditUserName().environmentObject(Store())
    }
}
