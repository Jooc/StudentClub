//
//  EditContactEmail.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/8.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct EditContactEmail: View {
    @EnvironmentObject var store: Store
    
    var user: User{
        self.store.appState.user ?? User.Sample()
    }
    
    @State var newContactEmail: String = ""
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.gray.opacity(0.1)
            
            VStack(spacing: 20) {
                HStack{
                    Button(action:{
                        self.store.appState.meState.editContactEmail = false
                    }){
                        Text("取消")
                            .foregroundColor(Color.black)
                            .padding(.all, 5)
                    }
                    
                    Spacer()
                    Text("修改联系方式")
                    Spacer()
                    
                    Button(action:{
                        if self.user.contactEmail != self.newContactEmail {
                            
                        }
                    }){
                        Text("确认")
                            .foregroundColor(Color.white)
                            .padding(.all, 10)
                            .background(user.contactEmail == newContactEmail ? Color.gray.opacity(0.5) : Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                
                TextField(user.contactEmail, text: self.$newContactEmail)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    .background(Color.white)
            }
        }
    }
}

struct EditContactEmail_Previews: PreviewProvider {
    static var previews: some View {
        EditContactEmail().environmentObject(Store())
    }
}
