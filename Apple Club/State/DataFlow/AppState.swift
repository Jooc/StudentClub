//
//  AppState.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

struct AppState{
    @FileStorage(directory: .documentDirectory, fileName: "user.json")
    var user: User?
    
    var loginState = LoginState()
    var newsState = NewsState()
    var postState = PostState()
    var meState = MeState()
    var calendarState = CalendarState()
    
    var showMe = false
    var closed = true
    
    init() {
        self.user = User.Sample()
    }
}

extension AppState{
    struct LoginState{
        class LoginAccount {
            var email = ""
            var password = ""
        }
        
//        var showLoginPage = false
        var isInputting = false
        var isLogining = false
        var loginAccount = LoginAccount()
        var loginError: AppError?
    }
}

extension AppState{
    struct NewsState {
        var newsListViewModel  = NewsListViewModel()
        
        var showAddButtons = false
        var pickImageActionSheet = false
        
        var detailedNews: NewsViewModel? = nil
        var isLoading = false
        var loadNewsError: AppError?
        
        
        mutating func showNewsDetail(news: NewsViewModel) {
            self.detailedNews = news
        }
    }
}

extension AppState{
    struct PostState {
        var title: String = ""
        var content: String = ""
        var image: Image? = nil
        var location: String = ""
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
        var isLoading = false
        var loadEventError: AppError?
        
        var currentMonth: Int = 4
        var selectedDay: EDayViewModel? = nil
        var selectedDayPreState: EDayState = .uncover
    }
}

extension AppState.CalendarState{
    mutating func clickDayCell(dayViewModel: EDayViewModel) {
        if selectedDay == nil{
            selectedDay = dayViewModel
            selectedDayPreState = selectedDay!.state
            selectedDay!.state = .selected
        }
        else{
            selectedDay?.state = selectedDayPreState
            if dayViewModel == selectedDay{
                selectedDay = nil
                selectedDayPreState = .uncover
            }else{
                selectedDayPreState = dayViewModel.state
                selectedDay = dayViewModel
                selectedDay?.state = .selected
            }
        }
    }
    
    mutating func nextMonth(){
        if currentMonth == 12{
            return
        }
        currentMonth += 1
    }
    
    mutating func lastMonth() {
        if currentMonth == 1{
            return
        }
        self.currentMonth -= 1
    }
}
