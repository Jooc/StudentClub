//
//  ClubMemberDetail.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/6/8.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ClubMemberDetail: View {
    
    @EnvironmentObject var store: Store
    
    var detailedMemberID: Int
    
    var detailedMember: User?{
        self.store.appState.clubState.detailedMember
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            if detailedMember != nil{
                VStack(spacing: 30){
                        ZStack(alignment: .center) {
                            Circle()
                                .frame(width: 110, height: 110)
                                .foregroundColor(Color.white)
                                .shadow(radius: 10)
                            KFImage(URL(string: Globals.OSSPrefix+self.detailedMember!.avatar) ?? Globals.defaultAvatarURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:100, height: 100)
                                    .clipShape(Circle())
                    }
                    
                    VStack(spacing: 30) {
                        Text(detailedMember!.name)
                            .font(.title)
                            .padding(.bottom, 50)
                        
                        HStack {
                            VStack(spacing: 30) {
                                HStack{
                                    Text("Phone: ")
                                        .font(.system(size: 20))
                                    Text(detailedMember!.phoneNumber)
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("Email: ")
                                        .font(.system(size: 20))
                                    Text(detailedMember!.contactEmail)
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("Club: ")
                                        .font(.system(size: 20))
                                    Text(detailedMember!.clubInfo.clubName)
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                            }
                        }.padding(.leading, 100)
                    }
                    Spacer()
                }.padding(.vertical, 50)
            }
            else{
                Text("Loading...")
            }
        }.onAppear(){
            self.store.dispatch(.loadUserDetail(userID: self.detailedMemberID))
        }
    }
}

struct ClubMemberDetail_Previews: PreviewProvider {
    static var previews: some View {
        ClubMemberDetail(detailedMemberID: 1).environmentObject(Store.Sample())
    }
}
