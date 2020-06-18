//
//  NewsDetailSlider.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/27.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct NewsDetailSlider: View {
    @EnvironmentObject var store: Store
    var body: some View {
        ZStack{
            Color("Base")
            if self.store.appState.detailedNews != nil{
                NewsDetail()
            }
        }
    }
}

struct NewsDetailSlider_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetailSlider()
    }
}
