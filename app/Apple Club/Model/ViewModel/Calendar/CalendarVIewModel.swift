//
//  CalendarVIewModel.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import SwiftUI

struct CalendarViewModel{
    let calendar = Calendar()
    var months = [EMonthViewModel]()
    var events = Dictionary<Int, Event>()
    
    var currentScrollOffset: CGFloat = 0
    
    init() {
        self.generateVMs()
    }
    
    
    var dragPosition = CGSize.zero
}

extension CalendarViewModel{
    
    private mutating func generateVMs() {
        for month in 1...12{
            let newMonthViewModel = EMonthViewModel(month: month)
            var preMonth = month - 2
            if preMonth < 0{
                preMonth += 12
            }
            let curMonth = month - 1
            let beginWeekDaySymbol = calendar.beginWeekdaySymbolOfMonth(month: month)
            
            //            print(String(month) + "begin with: " + String(beginWeekDaySymbol.text))
            newMonthViewModel.generateMonth(
                baseWeekday: beginWeekDaySymbol,
                preCount: calendar.daysCounts[preMonth],
                curCount: calendar.daysCounts[curMonth])
            months.append(newMonthViewModel)
        }
    }
    
    // Based on the year
    // Generate all viewModels of the whole year
    
    // TODO: get events from server
    private func generateEventFromResponse(response: Event) {
        let dateString = response.date
        let pars1 = dateString.prefix(upTo: dateString.lastIndex(of: " ")!)
            .split{$0 == "-"}
            .map(String.init)
            .map{string in Int(string)!}
        let pars2 = self.whichWeek(of: pars1[2], in: pars1[1])
        
        
        self.months[pars1[1]-1].weeks[pars2.0 - 1].days[pars2.1 - 1].events.append(response)
        //        self.months[3].weeks[2].days[3].events.append(response)
    }
    
    func updateEvents(with eventResponse: [Event]){
        for response in eventResponse{
            print(response.date)
            self.generateEventFromResponse(response: response)
        }
    }
    
    private func bindEvent2VM() {
        for (key, value) in self.events{
            let (month, week, day) = self.calendar.Index2MWD(index: key)
            self.months[month].weeks[week].days[day].events.append(value)
        }
    }
    
    private func updateEventFromVM(){
        //        if let index = self.selectedDayIndex{
        //            let (month, week, day) = self.calendar.Index2MWD(index: index)
        //            self.events[index] = self.months[month].weeks[week].days[day].event
        
        // TODO: uploadEvents2Server()
        //        }
    }
}

extension CalendarViewModel{
    func whichWeek(of date: Int, in month: Int) -> (Int,Int){
        for week in 0...months[month].weeks.count{
            for day in 0...6{
                if self.months[month - 1].weeks[week].days[day].model.date == date{
                    return (week + 1, day + 1)
                }
            }
        }
        return (0,0)
    }
}
