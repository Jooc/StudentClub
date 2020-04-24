//
//  AppAction.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

enum AppAction {
    
    case showLogin
    case beginInput
    case finishInput
    
    case clickDayCell(day: EDayViewModel)
    case selectMonth(month: Int)
    case nextPage
    case lastPage
    
}
