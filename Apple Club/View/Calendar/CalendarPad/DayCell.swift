//
//  DayCell.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct DayCell: View {
    @EnvironmentObject var store: Store
    
    var viewModel: EDayViewModel
    
    var body: some View {
        Text(viewModel.getStringDate())
            .frame(width: viewModel.size.width, height: viewModel.size.height)
            .background(viewModel.backGroundColor)
            .foregroundColor(viewModel.fontColor)
            .clipShape(Circle())
            .onTapGesture {
                self.store.dispatch(.clickDayCell(day: self.viewModel))
        }
    }
}

struct DayCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            DayCell(viewModel: EDayViewModel.Sample(date: nil, state: .uncover)).environmentObject(Store())
            DayCell(viewModel: EDayViewModel.Sample(date: nil, state: .available)).environmentObject(Store())
            DayCell(viewModel: EDayViewModel.Sample(date: nil, state: .selected)).environmentObject(Store())
            DayCell(viewModel: EDayViewModel.Sample(date: nil, state: .unavailable)).environmentObject(Store())
        }
    }
}
