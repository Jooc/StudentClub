//
//  ClubList.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/9.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct ClubListPage: View {
    @EnvironmentObject var store: Store
    
    var viewModel: ClubViewModel{
        self.store.appState.clubState.viewModel
    }
    
    @State var showBackButton: Bool = true
    
    var body: some View {
        NavigationView {
            List{
                ForEach(self.viewModel.clubs){ club in
                    NavigationLink(destination:
                        ClubDetail(clubCode: club.code)
                    ){
                        HStack(spacing: 15) {
                            KFImage(URL(string: Globals.OSSPrefix + club.icon))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                            
                            Text(club.name)
                        }.padding(.vertical, 5)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .onAppear(){
            self.store.dispatch(.loadClubList)
        }
    }
}

struct ClubListPage_Previews: PreviewProvider {
    static var previews: some View {
        ClubListPage().environmentObject(Store.Sample())
    }
}
