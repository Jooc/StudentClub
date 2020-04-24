//
//  MonthPad.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct MonthPad: View {
    @EnvironmentObject var store: Store
    
    var screen = UIScreen.main.bounds
    var viewModel: EMonthViewModel
    
    var body: some View {
        VStack(spacing: self.viewModel.space){
            ForEach(self.viewModel.weeks){week in
                WeekRow(viewModel: week)
            }
        }
        .frame(width: screen.width)
//        .padding(.vertical)
    }
}

struct MonthPad_Previews: PreviewProvider {
    static var previews: some View {
        MonthPad(viewModel: EMonthViewModel.Sample()).environmentObject(Store())
    }
}

