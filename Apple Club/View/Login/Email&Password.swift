//
//  Email&Password.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct Email_Password: View {
    @EnvironmentObject var store: Store
    
    var loginBinding: Binding<AppState.LoginState>{
        $store.appState.loginState
    }
    
    var body: some View {
        VStack() {
            HStack {
                Image(systemName: "person.circle.fill")
                    .foregroundColor(Color.black.opacity(0.6))
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y:5)
                    .padding(.leading)
                TextField("EMAIL".uppercased(), text: loginBinding.account.email)
                    .keyboardType(.emailAddress)
                    .font(.subheadline)
                    .padding(.leading)
                    .onTapGesture {
                        self.store.dispatch(.beginInput)
                }
                Spacer()
            }
            Divider()
                .padding(.leading, 70)
                .padding(.trailing, 30)
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundColor(Color.black.opacity(0.6))
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .shadow(color: Color.black.opacity(0.15), radius: 5, x: 0, y:5)
                    .padding(.leading)
                SecureField("PASSWORD".uppercased(), text: loginBinding.account.password)
                    .keyboardType(.default)
                    .font(.subheadline)
                    .padding(.leading)
                    .onTapGesture {
                        self.store.dispatch(.beginInput)
                }
                Spacer()
            }
        }
        .frame(width: screen.width*0.8, height: screen.width*0.35)
        .background(BlurView(style: .systemMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
        .shadow(radius: 20)
    }
    
    struct Email_Password_Previews: PreviewProvider {
        static var previews: some View {
            Email_Password().environmentObject(Store())
        }
    }
}
