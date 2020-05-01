//
//  AppAction.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

enum AppAction {
    
    // MARK: Login
    case input
    case inputDone
    case login(accout: AppState.LoginState.LoginAccount)
    case accountBehaviorDone(result: Result<User, AppError>)
//    case accountBehaviorDone(result: Result<UserResponse, AppError>)
    case logout
    
    // MARK: Loading
    case loadNews
    case loadNewsDone(result: Result<[News], AppError>)
    case loadEvents
    case loadEventsDone(result: Result<[Event], AppError>)
    
    // MARK: UI Event
    case clickDayCell(day: EDayViewModel)
    case clickNewsCell(news: NewsViewModel)
    case closeNewsDetail
    
    case selectMonth(month: Int)
    case nextPage
    case lastPage
    
}
