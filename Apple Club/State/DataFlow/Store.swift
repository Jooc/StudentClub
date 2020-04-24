//
//  Store.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

class Store: ObservableObject{
    @Published var appState = AppState()
    
    func dispatch(_ action: AppAction) {
        #if DEBUG
        print("[ACTION]:] \(action)")
        #endif
        
        let result = Store.reduce(state: self.appState, action: action)
        self.appState = result.0
        
        if let command = result.1{
            #if DEBUG
            print("[COMMAND]: \(command)")
            #endif
            command.excute(in: self)
        }
    }
    
    static func reduce(state: AppState, action: AppAction) -> (AppState, AppCommand?) {
        var appState = state
//        var appCommand = AppCommand?
        
        switch action {
        case .beginInput:
            appState.loginState.isInputting = true
        case .finishInput:
            appState.loginState.isInputting = false
        case .showLogin:
            appState.loginState.showLoginPage.toggle()
            
        case .clickDayCell(let day):
            appState.calendarState.calendarViewModel.clickDayCell(dayViewModel: day)
        case .nextPage:
            appState.calendarState.calendarViewModel.nextMonth()
        case .lastPage:
            appState.calendarState.calendarViewModel.lastMonth()
        case .selectMonth(let month):
            appState.calendarState.calendarViewModel.currentMonth = month
        }
        
        return (appState, nil)
    }
      
}
