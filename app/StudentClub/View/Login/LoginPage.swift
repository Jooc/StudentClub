//
//  LoginPage.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct LoginPage: View {
    @EnvironmentObject var store: Store
    
    var loginBinding: Binding<AppState.LoginState> {
        $store.appState.loginState
    }
    
    func hideKeyBoard( ){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            Color("Base")
                .edgesIgnoringSafeArea(.all)
            ZStack(alignment: .top) {
                background
            
                Email_Password()
                    .offset(y:screen.height*0.6)
                
                loginButton
                
            }
            .edgesIgnoringSafeArea(.all)
            .offset(y: self.store.appState.loginState.isInputting ? -screen.height*0.4 : 0)
            .animation(.easeInOut)
            .onTapGesture {
                self.store.dispatch(.inputDone)
                self.hideKeyBoard()
            }
        }
        .alert(item: loginBinding.loginError){error in
            Alert(title: Text(error.localizedDescription))
        }
    }
    
    var background: some View {
        VStack {
            HStack {
                Spacer()
//                CircleButton(icon: "text.justify")
//                    .padding(20)
//                    .offset(y: screen.height * 0.06)
            }
            Spacer()
        }
        .background(
            Image(uiImage: #imageLiteral(resourceName: "Logo"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: screen.width*0.5)
        )
        .background(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("Logo_green"), Color("Logo_purple")]),
                        startPoint: .bottomLeading,
                        endPoint: .topTrailing ))
                .shadow(color: Color("Logo_green").opacity(0.7), radius: 30)
        )
        .frame(maxWidth: .infinity, maxHeight: screen.height * 0.7)
        .offset(y: -30)
        
    }
    
    var loginButton: some View{
        VStack {
            Spacer()
            HStack(spacing: 40) {
                Spacer()
                Text("View as guest")
                    .foregroundColor(Color.gray)
                    .padding(.leading)
                Button(action: {
                    #if DEBUG
                    print("Login Button Clicked")
                    #endif
                    self.store.dispatch(.inputDone)
                    self.hideKeyBoard()
                    self.store.dispatch(.login(accout: self.store.appState.loginState.loginAccount))
                }){
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .padding(.horizontal, screen.width * 0.06)
                }
                .background(RadialGradient(
                    gradient: Gradient(colors: [Color("LoginButton_green"), Color("Logo_purple")]),
                    center: .bottomLeading,
                    startRadius: 15,
                    endRadius: 600
                )
                    .clipShape(RoundedRectangle(cornerRadius: screen.width * 0.07, style: .continuous))
                    .shadow(color: Color("LoginButton_green").opacity(0.3), radius: 20, x: 0, y: 20)
                )
            }
            .padding(.trailing, screen.width*0.1)
            .padding(.bottom, screen.height * 0.05)
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginPage().environmentObject(Store.Sample())
            LoginPage().environmentObject(Store.Sample()).previewDevice("iPhone 8")
        }
    }
}
