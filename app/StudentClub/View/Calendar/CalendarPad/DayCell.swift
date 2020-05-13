//
//  DayCell.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct DayCell: View {
    @EnvironmentObject var store: Store
    
    var viewModel: EDayViewModel
    
    var body: some View {
        VStack(spacing: 5) {
            Text(viewModel.getStringDate())
                .frame(width: viewModel.size.width, height: viewModel.size.height)
                .background(viewModel.backGroundColor)
                .foregroundColor(viewModel.fontColor)
                .clipShape(Circle())
                .onTapGesture {
                    self.store.dispatch(.clickDayCell(day: self.viewModel))
            }
            HStack(spacing: 2){
                ForEach(0..<self.viewModel.events.count) { item in
                    Circle()
                        .frame(width: 3, height: 3)
                        .foregroundColor(Color.red)
                }
            }
        }.frame(width: 38, height: 45, alignment: .top)
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
