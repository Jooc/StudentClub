//
//  ClubInfo.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/9.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ClubInfoPage: View {
    @EnvironmentObject var store: Store
    
    var viewModel: ClubViewModel{
        self.store.appState.clubState.viewModel
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List{
                    NavigationLink(destination:
                        Text(viewModel.myAdvisor.name)
                    ){
                        UserInfoCell(user: viewModel.myAdvisor)
                    }
                    
                    NavigationLink(destination:
                        Text(viewModel.myManager.name)
                    ){
                        UserInfoCell(user: viewModel.myManager)
                    }
                    
                    ForEach(self.viewModel.myClubMembers, id: \.self){ user in
                        NavigationLink(destination:
                            ClubMemberDetail(detailedMemberID: user.id)
                        ){
                            UserInfoCell(user: user)
                        }
                    }.onDelete{ index in
                        self.store.dispatch(.deleteClubMember(index: index.first!))
                    }
                }
                .navigationBarTitle(
                    Text("Members")
                        .font(.system(.body))
                )
                .navigationBarHidden(true)
            }
            
            Spacer()
        }
        .onAppear(){
            self.store.dispatch(.loadMyClubMembers)
        }
    }
}

struct ClubInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        ClubInfoPage().environmentObject(Store.Sample())
    }
}

struct UserInfoCell: View {
    var user: UserInfo
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            KFImage(URL(string: Globals.OSSPrefix + user.avatar))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            
            Text(user.name)
        }.padding(.vertical, 5)
    }
}
