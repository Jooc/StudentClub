//
//  EMonthViewModel.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import SwiftUI

class EMonthViewModel: Identifiable{
    var space: CGFloat = 25
    
    var year = 2020
    
    var weeks = [EWeekViewModel]()
    var month: Int
    
    init(month: Int) {
        self.month = month
    }
}

extension EMonthViewModel{
    func generateMonth(baseWeekday: WeekdaySymbol, preCount: Int, curCount: Int) {
        let firstweek = EWeekViewModel()
        var count = preCount - baseWeekday.rawValue
        //MARK: Error
        for i in 0..<baseWeekday.rawValue{
            firstweek.days.append(EDayViewModel(
                model: EDay(year: year, month: month, date: preCount-baseWeekday.rawValue + 1 + i),
                state: .uncover))
        }
        count = 1
        while firstweek.days.count < 7{
            firstweek.days.append(EDayViewModel(
                model: EDay(year: year, month: month, date: count), state: .available))
            count += 1
        }
        self.weeks.append(firstweek)
        
        var finish = false
        while !finish{
            let week = EWeekViewModel()
            for _ in 1...7{
                week.days.append(EDayViewModel(
                    model: EDay(year: year, month: month, date: count),
                    state: .available))
                count += 1
                if count == curCount + 1{
                    count = 1
                    while week.days.count < 7{
                        week.days.append(EDayViewModel(
                            model: EDay(year: year, month: month, date: count),
                            state: .uncover))
                        count += 1
                    }
                    finish = true
                }
                if finish{
                    break
                }
            }
            self.weeks.append(week)
        }
    }
}
