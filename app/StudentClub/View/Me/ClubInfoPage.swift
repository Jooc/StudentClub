//
//  ClubInfo.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/9.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct ClubInfoPage: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.store.appState.rightSliderPageState = .NONE
                }){
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("返回")
                    }
                    .foregroundColor(Color.black)
                    .padding(.all, 5)
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct ClubInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        ClubInfoPage()
    }
}
