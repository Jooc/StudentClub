//
//  BottomMenu.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/6/8.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct BottomMenu: View {
    
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack{
                if self.store.appState.detailsState.detailedUser != nil{
                    VStack {
                        Text(self.store.appState.detailsState.detailedUser!.name)
                    }
                }else{
                    Text("Loading...")
                }
            }.onAppear(){
                self.store.dispatch(.loadUserDetailForMainTab)
            }
            .animation(.spring())
        }
    }
}

struct BottomMenu_Previews: PreviewProvider {
    static var previews: some View {
        BottomMenu().environmentObject(Store.Sample())
    }
}
