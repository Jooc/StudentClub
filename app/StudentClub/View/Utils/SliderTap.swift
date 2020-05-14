//
//  SliderTap.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct SliderTap: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10)
            .frame(width: Globals.screen.width*0.3, height: 4)
            .foregroundColor(Color.gray.opacity(0.5))
    }
}

struct SliderTap_Previews: PreviewProvider {
    static var previews: some View {
        SliderTap()
    }
}
