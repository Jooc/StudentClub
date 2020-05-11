//
//  Calendar.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

class Calendar{
    var formatter = DateFormatter()
    
    var year = 2020
    var beignWeekday = WeekdaySymbol.Wednesday
    
    var days = [EDay]()
    var selectedDays = [EDay]()
    
    var daysCounts = [Int]()

    
    init() {
        self.generateCalendar()
    }
}

// Initial Functions
extension Calendar{
    static let common_daysCounts = [31,28,31,30,31,30,31,31,30,31,30,31]
    static let leap_daysCounts = [31,29,31,30,31,30,31,31,30,31,30,31]
    
    func generateCalendar() {
        if ifLeap() {
            self.daysCounts = Calendar.leap_daysCounts
        }else{
            self.daysCounts = Calendar.common_daysCounts
        }
        
        for monthIndex in 0..<12{
            for date in 1...self.daysCounts[monthIndex]{
                self.days.append(EDay(year: year, month: monthIndex+1, date: date))
            }
        }
    }
}

// Functional Utils
extension Calendar{
    func ifLeap() -> Bool {
        if year % 100 == 0{
            return year % 400 == 0
        }
        else{
            return year % 4 == 0
        }
    }
    
    func getWeekday(which day: Int) -> WeekdaySymbol{
        // begin with 1st
        // not zero
        return WeekdaySymbol(rawValue: (day % 7 - 1 + self.beignWeekday.rawValue)%7)!
    }
    
    func beginWeekdaySymbolOfMonth(month: Int) -> WeekdaySymbol {
        var beginDay = 1
        for i in 0..<month - 1{
            beginDay += self.daysCounts[i]
        }
        return self.getWeekday(which: beginDay)
    }
    
    func Index2MWD(index: Int) -> (Int, Int, Int) {
        var count = index
        var month = 0
        
        for (m, dayCount) in daysCounts.enumerated(){
            if count <= dayCount{
                month = m + 1
                break
            }
            count -= dayCount
        }
        
        return(month, count / 7 + 1, count%7)
    }
    
    func MWD2Index(month: Int, week: Int, day: Int) -> Int{
        return self.daysCounts[1..<month-1].reduce(0,+) + (week-1)*7 + day
    }
}
