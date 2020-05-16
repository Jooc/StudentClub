////
////  MeSlidePage.swift
////  StudentClub
////
////  Created by 齐旭晨 on 2020/4/26.
////  Copyright © 2020 齐旭晨. All rights reserved.
////
//
//import SwiftUI
//
//struct MeSlidePage: View {
//    @EnvironmentObject var store: Store
//    @State var show = false
//    
//    var user: User{
//        self.store.appState.loginState.user ?? User.defaultUser()
//    }
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            HStack {
//                avatar
////                Text(user.userName)
//            }
//            buttonList
//        }
//        .padding(.vertical, 100)
//        .padding(.horizontal, 20)
//        .frame(width: Globals.screen.width*0.9, height: Globals.screen.height*0.9, alignment: .topLeading)
//        .background(BlurView(style: .systemMaterial))
//        .cornerRadius(20)
//    }
//    
//    var avatar: some View{
//        VStack(spacing: 10) {
//            ZStack {
//                Circle()
//                    .frame(width: 80, height: 80)
//                    .foregroundColor(Color.white)
//                    .shadow(radius: 10)
//                Image(uiImage: #imageLiteral(resourceName: "avatar-1"))
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 75, height: 75)
//                    .clipShape(Circle())
//            }
//            Text(user.userName)
//        }
//    }
//    
//    var buttonList: some View {
//        VStack(spacing: 60){
//            VStack(spacing: 20) {
//                Button(action: {self.show.toggle()}){
//                    ButtonLabel(icon: "person.circle.fill", text: "名片")
//                }
//                .sheet(isPresented: $show){
//                    Text("123123123")
//                        .onTapGesture {
//                            self.show.toggle()
//                    }
//                }
//                
//                Button(action: {}){
//                    ButtonLabel(icon: "tray.full.fill", text: "新闻库")
//                }
//                Button(action: {}){
//                    ButtonLabel(icon: "book.circle.fill", text: "Blog")
//                }
//            }
//            VStack(spacing: 20) {
//                HStack{
//                    Button(action:{}){
//                        ButtonLabel(icon: "person.2.fill", text: "俱乐部")
//                    }
//                    .padding(.trailing, 10)
//                    Button(action:{}){
//                        ButtonLabel(icon:"person.2.square.stack.fill", text: "")
//                            .frame(width: 55)
//                    }
//                }
//            }
//            VStack(){
//                Button(action: {
//                    self.store.dispatch(.logout)
//                }){
//                    Text("退出登录")
//                        .font(.system(size: 20))
//                        .fontWeight(.regular)
//                        .foregroundColor(Color.red)
//                        .frame(height: 55)
//                        .frame(maxWidth: .infinity)
//                        .background(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//                        .shadow(color: Color.red.opacity(0.1), radius: 5)
//                        .shadow(radius: 5)
//                }
//                .offset(y: 30)
//            }
//        }
//        .frame(width: Globals.screen.width*0.7, height: 500, alignment: .top)
//        .padding()
//        .padding(.top, 40)
//    }
//}
//
//struct ButtonLabel: View {
//    var icon: String
//    var text: String
//    
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .foregroundColor(Color.black.opacity(0.7))
//                .font(.system(size: 22))
//                .padding()
//                .padding(.leading, 10)
//            
//            Text(text)
//                .font(.system(size: 22))
//                .fontWeight(.regular)
//                .foregroundColor(Color.black.opacity(0.6))
//        }
//        .frame(height: 55)
//        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(Color.white)
//        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
//        .shadow(radius: 3)
//    }
//}
//
//
//struct MeSlidePage_Previews: PreviewProvider {
//    static var previews: some View {
//        MeSlidePage().environmentObject(Store())
//    }
//}
//
//
