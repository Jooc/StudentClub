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
        var appCommand: AppCommand?
        
        switch action {
        case .input:
            appState.loginState.isInputting = true
        case .inputDone:
            appState.loginState.isInputting = false
        case .login(let account):
            guard !appState.loginState.isLogining else{
                break
            }
            appState.loginState.isLogining = true
            appCommand = LoginAppCommand(email: account.email, password: account.password)
        case .accountBehaviorDone(let result):
            appState.loginState.isLogining = false
            switch result {
            case .success(let user):
                appState.user = user
                appCommand = LoadNewsAppCommand(userPrivilege: user.userPrivilege)
            case .failure(let error):
                appState.loginState.loginError = error
                print("[ERROR]: \(error.localizedDescription)")
            }
        case .logout:
            appState.user = nil
            
        case .loadNews:
            guard !appState.newsState.isLoading else{
                break
            }
            appState.newsState.isLoading = true
            appCommand = LoadNewsAppCommand(userPrivilege: appState.user?.userPrivilege ?? 0)
        case .loadNewsDone(let result):
            appState.newsState.isLoading = false
            switch result {
            case .success(let newsList):
                appState.newsState.newsListViewModel.updateNews(newsList: newsList)
                // TODO: Maybe this should be placed in .accountBehaviorDone
                // TODO: OR simply combined with loadNews
                appCommand = LoadEventsAppCommand(userID: appState.user!.id)
            case .failure(let error):
                appState.newsState.loadNewsError = error
                print("[ERROR]: \(error.localizedDescription)")
            }
        case .loadEvents:
            guard !appState.calendarState.isLoading else{
                break
            }
            appState.calendarState.isLoading = true
            appCommand = LoadEventsAppCommand(userID: appState.user!.id)
        case .loadEventsDone(let result):
            appState.calendarState.isLoading = false
            switch result {
            case .success(let events):
                appState.calendarState.calendarViewModel.updateEvents(with: events)
            case .failure(let error):
                appState.calendarState.loadEventError = error
                print("[ERROR]: \(error.localizedDescription)")
            }
            
        case .clickDayCell(let day):
            appState.calendarState.clickDayCell(dayViewModel: day)
        case .clickNewsCell(let news):
            appState.newsState.showNewsDetail(news: news)
        case .closeNewsDetail:
            appState.newsState.detailedNews = nil
        case .nextPage:
            appState.calendarState.nextMonth()
        case .lastPage:
            appState.calendarState.lastMonth()
        case .selectMonth(let month):
            appState.calendarState.currentMonth = month
        }
        
        return (appState, appCommand)
    }
      
}
