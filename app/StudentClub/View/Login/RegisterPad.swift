//
//  SignInPad.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/14.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct RegisterPad: View {
    @EnvironmentObject var store: Store
    
    @State var showRegisterVerify: Bool = false
    
    var registerState: AppState.LoginState{
        self.store.appState.loginState
    }
    
    var accountBinding: Binding<AppState.LoginState.RegisterAccountChecker>{
        self.$store.appState.loginState.registerAccountChecker
    }
    
    var body: some View {
        VStack(spacing: 15) {
            Spacer()
            
            if self.showRegisterVerify{
                if self.store.appState.loginState.registerAccountChecker.isRegisterCodeValid{
                    Text("valid register code: " + self.store.appState.loginState.registerAccountChecker.validClubName)
                        .foregroundColor(Color.green.opacity(0.7))
                        .padding(.leading, 5)
                        .offset(y: 10)
                }else{
                    Text("invalid register code")
                        .foregroundColor(Color.red)
                        .padding(.leading, 5)
                        .offset(y: 10)
                }
            }
            
            VStack {
                TextField("register code", text: accountBinding.registerCode)
                    .modifier(TextFieldCustomModifier())
                HStack {
                    Spacer()
                    Button(action: {
                        self.showRegisterVerify = true
                        self.store.dispatch(.verifyRegisterCode)
                    }){
                        Text("verify")
                            .foregroundColor(Color.blue)
                    }.padding(.horizontal)
                }
            }.padding(.bottom)
            TextField("login email", text: accountBinding.loginEmail)
                .foregroundColor(self.registerState.isRegisterEmailValid ? Color.black : Color.red)
                .modifier(TextFieldCustomModifier())
            
            TextField("user name", text: accountBinding.userName)
                .modifier(TextFieldCustomModifier())
            
            SecureField("password", text: accountBinding.password)
                .modifier(TextFieldCustomModifier())
            
            SecureField("verify password", text: accountBinding.verifyPassword)
                .modifier(TextFieldCustomModifier())
            
            HStack {
                Spacer()
                Button(action: {
                    self.store.dispatch(.register)
                }){
                    Text("Register")
                        .foregroundColor(.white)
                        .padding()
                        .lineLimit(1)
                        .frame(width: Globals.screen.width*0.3, alignment: .center)
                }
                .background(RadialGradient(
                    gradient: Gradient(colors: [Color("LoginButton_green"), Color("Logo_purple")]),
                    center: .bottomLeading,
                    startRadius: 15,
                    endRadius: 600
                )
                    .clipShape(RoundedRectangle(cornerRadius: 23, style: .continuous))
                    .shadow(color: Color("LoginButton_green").opacity(0.3), radius: 20, x: 0, y: 20)
                )
            }.padding(.top, 30)
        }
        .padding(.horizontal, 35)
        .padding(.vertical, 50)
        .frame(width: Globals.screen.width*0.8, height: Globals.screen.height*0.9)
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(radius: 20)
    }
}

struct RegisterPad_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPad().environmentObject(Store())
    }
}

struct TextFieldCustomModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color("Base"))
            .cornerRadius(15)
    }
}
