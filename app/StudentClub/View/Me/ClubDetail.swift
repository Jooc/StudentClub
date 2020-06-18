//
//  ClubDetail.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/6/8.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ClubDetail: View {
    
    @EnvironmentObject var store: Store
    
    var detailedClub: Club?{
        self.store.appState.clubState.detailedClub
    }
    
    var clubCode: Int
    
    var body: some View {
        VStack {
            
            if detailedClub != nil{
                VStack(spacing: 30){
                        ZStack(alignment: .center) {
                            Circle()
                                .frame(width: 110, height: 110)
                                .foregroundColor(Color.white)
                                .shadow(radius: 10)
                            KFImage(URL(string: Globals.OSSPrefix+self.detailedClub!.icon) ?? Globals.defaultAvatarURL)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width:100, height: 100)
                                    .clipShape(Circle())
                    }
                    
                    VStack(spacing: 30) {
                        Text(detailedClub!.name)
                            .font(.title)
                            .padding(.bottom, 50)
                        
                        HStack {
                            VStack(spacing: 30) {
                                HStack{
                                    Text("Advisor: ")
                                        .font(.system(size: 20))
                                    Text(detailedClub!.advisor.name)
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                                
                                HStack{
                                    Text("Manager: ")
                                        .font(.system(size: 20))
                                    Text(detailedClub!.manager.name)
                                        .font(.system(size: 20))
                                    Spacer()
                                }
                            }
                        }.padding(.leading, 100)
                    }
                    Spacer()
                }.padding(.vertical, 50)
            }else{
                Text("Loading")
            }
        }.onAppear(){
            self.store.dispatch(.loadClubDetail(clubCode: self.clubCode))
        }
    }
}

struct ClubDetail_Previews: PreviewProvider {
    static var previews: some View {
        ClubDetail(clubCode: 0).environmentObject(Store.Sample())
    }
}
