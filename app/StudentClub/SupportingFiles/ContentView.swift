//
//  ContentView.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/2.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ContentView: View {
    var body: some View {
        KFImage(URL(string: "https://jooc-studentclub.oss-cn-huhehaote.aliyuncs.com/UserAvatar/1.png")!)
        .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
