//
//  ProfileInfo.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/3.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ProfileInfo: View {
    @EnvironmentObject var store: Store
    
    var user: User{
        self.store.appState.loginState.user ?? User.Sample()
    }
    
    var meBinding: Binding<AppState.MeState>{
        self.$store.appState.meState
    }
    
    @State var gender: Gender = .undefined
    
    var body: some View {
        VStack {
            header
                .padding(.top)
            
            Form{
                Section(header: Text("个人信息")){
                    HStack {
                        Text("ID")
                        Spacer()
                        EditableText(content: String(user.id))
                    }
                    .frame(height: 50)
                    
                    ZStack{
                        Color.white
                        HStack(spacing: 15) {
                            Text("头像")
                            Spacer()
                            KFImage(URL(string: user.avatar))
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                                .aspectRatio(contentMode: .fit)
                                .padding(.all, 5)
                            rightArrow
                        }
                        .frame(height: 70)
                    }
                    .sheet(isPresented: self.meBinding.editAvatar){
                        EditAvatar().environmentObject(self.store)
                    }
                    .onTapGesture {
                        self.store.appState.meState.editAvatar = true
                    }
                    
                    ZStack {
                        Color.white
                        HStack {
                            Text("用户名")
                            Spacer()
                            EditableText(content: user.name)
                            rightArrow
                        }
                        .frame(height: 50)
                    }
                    .onTapGesture {
                        self.store.appState.meState.editUserName = true
                    }
                    .sheet(isPresented: self.meBinding.editUserName){
                        EditUserName().environmentObject(self.store)
                    }
                    
//                    HStack {
//                        Text("性别")
//                        Spacer()
//                        // Picker
//                        EditableText(content: user.gender)
//                        rightArrow
//                    }
//                    .frame(height: 50)
//                    .onTapGesture {
//                        self.store.appState.meState.editGender = true
//                    }
//                    .sheet(isPresented: self.meBinding.editGender){
//                        EditGender().environmentObject(self.store)
//                    }
                    
                    ZStack{
                        Color.white
                        HStack {
                            Text("电话")
                            Spacer()
                            EditableText(content: user.phoneNumber)
                            rightArrow
                        }
                        .frame(height: 50)
                    }
                    .sheet(isPresented: self.meBinding.editPhoneNumber){
                        EditPhoneNumber().environmentObject(self.store)
                    }
                    .onTapGesture {
                        self.store.appState.meState.editPhoneNumber = true
                    }
                    
                    ZStack{
                        Color.white
                        HStack {
                            Text("联系邮箱")
                            Spacer()
                            EditableText(content: user.contactEmail)
                            rightArrow
                        }
                        .frame(height: 50)
                    }
                    .sheet(isPresented: self.meBinding.editContactEmail){
                        EditContactEmail().environmentObject(self.store)
                    }
                    .onTapGesture {
                        self.store.appState.meState.editContactEmail = true
                    }
                }
            }
        }
    }
    
    var header: some View{
        HStack{
            Button(action: {
                self.store.appState.rightSliderPageState = .NONE
            }){
                HStack(spacing: 5) {
                    Image(systemName: "chevron.left")
                    Text("返回")
                }
                .foregroundColor(Color.blue)
                .padding(.leading, -5)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
    
    var rightArrow: some View{
        Image(systemName: "chevron.right")
            .foregroundColor(Color.gray)
    }
}

struct ProfileInfo_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfo().environmentObject(Store.Sample())
    }
}

struct EditableText: View {
    var content: String
    
    var body: some View {
        Text(content)
            .padding(.horizontal)
            .foregroundColor(Color.gray)
    }
}
