//
//  MonthSymbol.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/21.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

enum MonthSymbol: Int, Hashable {
    case January = 1
    case Febuary = 2
    case March = 3
    case April = 4
    case May = 5
    case June = 6
    case July = 7
    case August = 8
    case September = 9
    case October = 10
    case November = 11
    case December = 12
}

extension MonthSymbol {
    var text: String{
        switch self {
        case .January: return "January"
        case .Febuary: return "Febuary"
        case .March: return "March"
        case .April: return "April"
        case .May: return "May"
        case .June: return "June"
        case .July: return "July"
        case .August: return "August"
        case .September: return "September"
        case .October: return "October"
        case .November: return "November"
        case .December: return "December"
        }
    }
    
    var abbr: String{
        switch self {
        case .January: return "Jan."
        case .Febuary: return "Feb."
        case .March: return "Mar."
        case .April: return "Apr."
        case .May: return "May."
        case .June: return "Jun."
        case .July: return "Jul."
        case .August: return "Aug."
        case .September: return "Sept."
        case .October: return "Oct."
        case .November: return "Nov."
        case .December: return "Dec"
        }
    }
}
