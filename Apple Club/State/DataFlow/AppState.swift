//
//  AppState.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct AppState{
    var loginState = LoginState()
    var meState = MeState()
    var calendarState = CalendarState()
    
}

extension AppState{
    struct LoginState{
        class LoginAccount {
            @Published var email = ""
            @Published var password = ""
        }
        
        var showLoginPage = false
        var isInputting = false
        
        var account = LoginAccount()
    }
}

extension AppState{
    struct MeState{
        
    }
}

extension AppState{
    struct CalendarState{
        var calendarViewModel = CalendarViewModel()
        
        var monthCount = 12
    }
}
