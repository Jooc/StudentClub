//
//  CalendarVIewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import SwiftUI

class CalendarViewModel{
    let calendar = Calendar()
    @Published var months = [EMonthViewModel]()
    
    var currentScrollOffset: CGFloat = 0
    
    init() {
        self.generateVMs()
    }
    
    
    var dragPosition = CGSize.zero
}

extension CalendarViewModel{
    private func generateVMs() {
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
    private func generateEventFromResponse(response: Event, userID: Int) {
        let startDateString = response.startDate
//        let endDateString = response.endDate
        
        //TODO: 目前只有开始日期被标注，多日型活动无法标注
        let pars1 = startDateString
            .split{$0 == "-"}
            .map(String.init)
            .map{string in Int(string)!}
        let pars2 = self.whichWeek(of: pars1[2], in: pars1[1])
        
//        self.months[pars1[1]-1].weeks[pars2.0-1].days[pars2.1-1].events.removeAll()
        
        self.months[pars1[1]-1].weeks[pars2.0 - 1].days[pars2.1 - 1].events.append(response)
        let participantArray =
            response.participant
                .dropFirst().dropLast()
                .split(separator: ",")
                .map(String.init)
                .map{$0.trimmingCharacters(in: CharacterSet.whitespaces)}
                .map{Int($0)}
        
        //TODO: How to deal with preState
        if participantArray.contains(userID){
            self.months[pars1[1]-1].weeks[pars2.0 - 1].days[pars2.1 - 1].state = .participated
        }
        
        
    }
    
    func updateEvents(with eventResponse: [Event], userID: Int){
        for response in eventResponse{
            print(response.startDate)
            self.generateEventFromResponse(response: response, userID: userID)
        }
    }
    
    func updateSingleEventParticipant(with response: Event, userId: Int) {
        let startDateString = response.startDate
        let pars1 = startDateString
            .split{$0 == "-"}
            .map(String.init)
            .map{string in Int(string)!}
        let pars2 = self.whichWeek(of: pars1[2], in: pars1[1])
        
        for index in self.months[pars1[1]-1].weeks[pars2.0 - 1].days[pars2.1 - 1].events.indices{
            if self.months[pars1[1]-1].weeks[pars2.0 - 1].days[pars2.1 - 1].events[index].id == response.id{
                self.months[pars1[1]-1].weeks[pars2.0 - 1].days[pars2.1 - 1].events[index].participant = response.participant
            }
        }
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
