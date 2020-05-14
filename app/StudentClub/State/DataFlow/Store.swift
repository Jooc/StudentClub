//
//  Store.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class Store: ObservableObject{
    @Published var appState = AppState()
    private var disposeBag = Set<AnyCancellable>()
    
    init() {
        setObservers()
    }
    
    func setObservers(){
        appState.loginState.loginAccountChecker.isEmailValid.sink{ isValid in
            self.dispatch(.loginEmailValid(valid: isValid))
        }.store(in: &disposeBag)
        appState.loginState.registerAccountChecker.isEmailValid.sink{isValid in
            self.dispatch(.registerEmailValid(valid: isValid))
        }.store(in: &disposeBag)
    }
    
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
        case .loginEmailValid(let valid):
            appState.loginState.isLoginEmailValid = valid
        case .registerEmailValid(let valid):
            appState.loginState.isRegisterEmailValid = valid
        case .input:
            appState.loginState.isInputting = true
        case .inputDone:
            appState.loginState.isInputting = false
        case .login(let email, let password):
            guard !appState.loginState.isLogining else{
                break
            }
            appState.loginState.isLogining = true
            appCommand = LoginAppCommand(email: email, password: password)
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
            guard !appState.postListState.isLoading else{
                break
            }
            appState.postListState.isLoading = true
            appCommand = LoadNewsAppCommand(userPrivilege: appState.user?.userPrivilege ?? 0)
        case .loadNewsDone(let result):
            appState.postListState.isLoading = false
            switch result {
            case .success(let newsList):
//                appState.postListState.postListViewModel.updateNews(newsList: newsList)
                // TODO: Maybe this should be placed in .accountBehaviorDone
                // TODO: OR simply combined with loadNews
                appCommand = LoadEventsAppCommand(userID: appState.user!.id)
            case .failure(let error):
                appState.postListState.loadNewsError = error
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
        case .loadBlogLPMetaData(blogIndex: let index):
            appCommand = LoadLPMetaDataAppCommand(blogIndex: index)
        case .loadBlogLPMetaDataDone(blogIndex: let index, result: let result):
            switch result{
            case .success(let data):
                appState.postListState.postListViewModel.dailyPostList[index.0].blogList[index.1].metaData = data
            case .failure(let error):
                print("[ERROR]: \(error.localizedDescription)")
            }
            
        case .clickDayCell(let day):
            appState.calendarState.clickDayCell(dayViewModel: day)
        case .clickNewsCell(let news):
            appState.postListState.showNewsDetail(news: news)
        case .closeNewsDetail:
            appState.postListState.detailedNews = nil
        case .nextPage:
            appState.calendarState.nextMonth()
        case .lastPage:
            appState.calendarState.lastMonth()
        case .selectMonth(let month):
            appState.calendarState.currentMonth = month
        
//        case .postNews:
//            appState.showPostNewsPage = true
//        case .postNewsDone:
//            break
        }
        
        return (appState, appCommand)
    }
      
}
