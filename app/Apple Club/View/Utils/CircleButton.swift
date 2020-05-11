//
//  CircleButton.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct CircleButton: View {
    var icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color.black)
        }
        .frame(width: 44, height: 44)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.gray.opacity(0.5), radius: 15, y: 15)
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(icon: "person.circle.fill")
    }
}
