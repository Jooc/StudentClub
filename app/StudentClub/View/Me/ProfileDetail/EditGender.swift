////
////  EditGender.swift
////  StudentClub
////
////  Created by 齐旭晨 on 2020/5/19.
////  Copyright © 2020 齐旭晨. All rights reserved.
////
//
//import SwiftUI
//
//struct EditGender: View {
//    @EnvironmentObject var store: Store
//    
//    enum Gender: String, CaseIterable {
//        case Male, Female, undefined
//    }
//    
//    var user: User{
//        self.store.appState.loginState.user ?? User.Sample()
//    }
//    
//    @State var newGender: Gender = .undefined
//    
//    var body: some View {
//        ZStack(alignment: .top) {
//            Color.gray.opacity(0.1)
//            
//            VStack(spacing: 20) {
//                HStack{
//                    Button(action:{
//                        self.store.appState.meState.editGender = false
//                    }){
//                        Text("取消")
//                            .foregroundColor(Color.black)
//                            .padding(.all, 5)
//                    }
//                    
//                    Spacer()
//                    Text("修改性别")
//                    Spacer()
//                    
//                    Button(action:{
//                        if self.user.gender != self.newGender.rawValue {
////                            self.store.dispatch(.editProfileInfo(target: .name, param: self.newName.wrappedValue))
//                        }
//                    }){
//                        Text("确认")
//                            .foregroundColor(Color.white)
//                            .padding(.all, 10)
//                            .background(user.gender == newGender.rawValue ? Color.gray.opacity(0.5) : Color.green)
//                            .clipShape(RoundedRectangle(cornerRadius: 5))
//                    }
//                }
//                .padding(.horizontal, 10)
//                .padding(.vertical, 10)
//                
//                Form{
//                    Section{
//                        Picker(selection: self.$newGender, label: Text("性别")){
//                            ForEach(Gender.allCases, id: \.self) {
//                                Text($0.rawValue)
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
//
//struct EditGender_Previews: PreviewProvider {
//    static var previews: some View {
//        EditGender().environmentObject(Store.Sample())
//    }
//}
