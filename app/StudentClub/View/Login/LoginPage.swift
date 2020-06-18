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
    
    var loginState: AppState.LoginState.LoginBehavior{
        self.store.appState.loginState.loginBehavior
    }
    @GestureState private var translation = CGPoint.zero
    
    func hideKeyBoard( ){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    var body: some View {
        ZStack {
            Color("Base")
                .edgesIgnoringSafeArea(.all)
                .blur(radius: (self.loginState==AppState.LoginState.LoginBehavior.register) ? 5:0)
            ZStack(alignment: .top) {
                background
                    .offset(y: self.store.appState.loginState.isInputting ? 50 : 0)
                    .blur(radius: (self.loginState==AppState.LoginState.LoginBehavior.register) ? 5:0)

                LoginPad()
                    .offset(y:Globals.screen.height*0.53)
                    .offset(x: (self.loginState==AppState.LoginState.LoginBehavior.login) ? 0:-Globals.screen.width)
                    .offset(x: self.translation.x)
                    .gesture(
                        DragGesture().updating($translation){ current, state, _ in
                            state.x = current.translation.width
//                            print(current.translation.width)
                        }
                        .onEnded(){ state in
                            if state.predictedEndTranslation.width < -Globals.screen.width*0.5{
                                self.store.appState.loginState.loginBehavior = AppState.LoginState.LoginBehavior.register
                                self.hideKeyBoard()
                            }
                    })
                
                loginButton
                    .blur(radius: (self.loginState==AppState.LoginState.LoginBehavior.register) ? 5:0)
                
                RegisterPad()
                    .offset(y:50)
                    .offset(x: (self.loginState==AppState.LoginState.LoginBehavior.register) ? 0:Globals.screen.width*2)
                    .offset(x: self.translation.x)
                    .scaleEffect((self.loginState==AppState.LoginState.LoginBehavior.register) ? 1:0.5 )
                    .gesture(
                        DragGesture().updating($translation){ current, state, _ in
                            state.x = current.translation.width
                        }
                        .onEnded(){ state in
                            if state.predictedEndTranslation.width > Globals.screen.width*0.5{
                                self.store.appState.loginState.loginBehavior = AppState.LoginState.LoginBehavior.login
                            }
                    })
            }
            .edgesIgnoringSafeArea(.all)
            .offset(y: self.store.appState.loginState.isInputting ? -Globals.screen.height*0.35 : 0)
            .onTapGesture {
                self.store.dispatch(.inputDone)
                self.hideKeyBoard()
            }
        }
        .animation(.spring())
        .alert(item: self.$store.appState.loginState.loginError){error in
            Alert(title: Text(error.localizedDescription))
        }
        .alert(item: self.$store.appState.loginState.registerError){error in
            Alert(title: Text(error.localizedDescription))
        }
    }
    
    var background: some View {
        VStack {
            HStack {
                Spacer()
//                CircleButton(icon: "text.justify")
//                    .padding(20)
//                    .offset(y: Globals.screen.height * 0.06)
            }
            Spacer()
        }
        .background(
            Image(uiImage: #imageLiteral(resourceName: "Logo"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: Globals.screen.width*0.5)
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
        .frame(maxWidth: .infinity, maxHeight: Globals.screen.height * 0.7)
        .offset(y: -60)
        
    }
    
    var loginButton: some View{
        VStack {
            Spacer()
            HStack(spacing: 40) {
                Button(action:{
                    self.store.dispatch(.loginAsGuest)
                }){
                    Text("view as guest")
                        .lineLimit(1)
                        .foregroundColor(Color.gray)
                        .padding(.trailing, 30)
                }
                
                Button(action: {
                    #if DEBUG
                    print("Login Button Clicked")
                    #endif
                    self.store.dispatch(.inputDone)
                    self.hideKeyBoard()
                    self.store.dispatch(
                        .login(
                            emai: self.store.appState.loginState.loginAccountChecker.email,
                            password: self.store.appState.loginState.loginAccountChecker.password)
                    )
                }){
                    Text("Login")
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
            }
            .frame(width: Globals.screen.width*0.8, alignment: .trailing)
            .padding(.bottom, 50)
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage().environmentObject(Store.Sample())
    }
}
