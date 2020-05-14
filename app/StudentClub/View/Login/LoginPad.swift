//
//  Email&Password.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct LoginPad: View {
    @EnvironmentObject var store: Store
    
    var loginState: AppState.LoginState{
        self.store.appState.loginState
    }
    
    var accountBinding: Binding<AppState.LoginState.LoginAccountChecker>{
        $store.appState.loginState.loginAccountChecker
    }
    
    var body: some View {
        VStack() {
            HStack {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(Color.gray.opacity(0.8))
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y:5)
                    .padding(.leading)
                TextField("EMAIL".uppercased(), text: accountBinding.email)
                    .foregroundColor(loginState.isLoginEmailValid ? Color.black : Color.red)
                    .keyboardType(.emailAddress)
                    .font(.subheadline)
                    .padding(.leading)
                    .onTapGesture {
                        self.store.dispatch(.input)
                }
                Spacer()
            }
            Divider()
                .padding(.leading, 70)
                .padding(.trailing, 30)
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(Color.gray.opacity(0.8))
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y:5)
                    .padding(.leading)
                SecureField("PASSWORD".uppercased(), text: accountBinding.password)
                    .keyboardType(.default)
                    .font(.subheadline)
                    .padding(.leading)
                    .onTapGesture {
                        self.store.dispatch(.input)
                }
                Spacer()
            }
        }
        .frame(width: Globals.screen.width*0.8, height: Globals.screen.width*0.35)
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(radius: 20)
    }
    
    struct LoginPad_Previews: PreviewProvider {
        static var previews: some View {
            LoginPad().environmentObject(Store())
        }
    }
}
