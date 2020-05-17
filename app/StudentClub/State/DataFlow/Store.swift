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
        print("[ACTION]: \(action)")
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
                appState.loginState.user = user
                appCommand = LoadNewsAppCommand(userPrivilege: user.userPrivilege)
            case .failure(let error):
                appState.loginState.loginError = error
                print("[ERROR]: \(error.localizedDescription)")
            }
        case .logout:
            appState.loginState.user = nil
        case .register:
            guard !appState.loginState.isRegistering else {
                break
            }
            if appState.loginState.registerAccountChecker.password != appState.loginState.registerAccountChecker.verifyPassword{
                appState.loginState.registerError = AppError.passwordDifferent
            }
            appCommand = RegisterAppCommand(
                registerCode: appState.loginState.registerAccountChecker.registerCode,
                loginEmail: appState.loginState.registerAccountChecker.loginEmail,
                userName: appState.loginState.registerAccountChecker.userName,
                password: appState.loginState.registerAccountChecker.password)
        
        case .registerDone(result: let result):
            switch result {
            case .success(let loginEmail):
                appState.loginState.loginAccountChecker.email = loginEmail
                appState.loginState.loginBehavior = AppState.LoginState.LoginBehavior.login
            case . failure(let error):
                appState.loginState.registerError = error
            }
            
        case .loadNews:
            guard !appState.postListState.isLoading else{
                break
            }
            appState.postListState.isLoading = true
            appCommand = LoadNewsAppCommand(userPrivilege: appState.loginState.user?.userPrivilege ?? 0)
        case .loadNewsDone(let result):
            appState.postListState.isLoading = false
            switch result {
            case .success(let newsList):
                appState.postListState.postListViewModel.updateNews(newsList: newsList)
                // TODO: Maybe this should be placed in .accountBehaviorDone
                // TODO: OR simply combined with loadNews
            case .failure(let error):
                appState.postListState.loadNewsError = error
                print("[ERROR]: \(error.localizedDescription)")
            }
            
            case .loadBlog:
//                guard !appState.postListState.isLoading else{
//                    break
//                }
                appState.postListState.isLoading = true
                appCommand = LoadBlogAppCommand(userPrivilege: appState.loginState.user?.userPrivilege ?? 0)
        case .loadBlogDone(result: let result):
                appState.postListState.isLoading = false
                switch result {
                case .success(let blogList):
                    appState.postListState.postListViewModel.updateBlog(blogList: blogList)
                    // TODO: Maybe this should be placed in .accountBehaviorDone
                    // TODO: OR simply combined with loadNews
//                    appCommand = LoadEventsAppCommand(userID: appState.loginState.user?.id ?? 0)
                case .failure(let error):
                    appState.postListState.loadNewsError = error
                    print("[ERROR]: \(error.localizedDescription)")
                }
            
        case .loadEvents:
            guard !appState.calendarState.isLoading else{
                break
            }
            appState.calendarState.isLoading = true
            appCommand = LoadEventsAppCommand(userID: appState.loginState.user!.id)
        case .loadEventsDone(let result):
            appState.calendarState.isLoading = false
            switch result {
            case .success(let events):
                appState.calendarState.calendarViewModel.updateEvents(with: events)
            case .failure(let error):
                appState.calendarState.loadEventError = error
                print("[ERROR]: \(error.localizedDescription)")
            }
            
        case .loadBlogLPMetaData(let index):
            appCommand = LoadLPMetaDataAppCommand(blogIndex: index)
        case .loadBlogLPMetaDataDone(blogIndex: let index, result: let result):
            switch result{
            case .success(let data):
                appState.postListState.postListViewModel.blogList[index].metaData = data
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
        case .postNews:
            guard !appState.postState.isPosting else{
                break
            }
            appState.postState.isPosting = true
            appCommand = PostNewsAppCommand(publsiher_id: appState.loginState.user!.id,
                                            title: appState.postState.title, content: appState.postState.content,
                                            tags: appState.postState.tags, privilege: appState.postState.privilege,
                                            image: appState.postState.image)
        case .postNewsDone(let result):
            appState.postState.isPosting = false
            switch result {
            case .success(let news):
                appState.postListState.postListViewModel.newsList.insert(NewsViewModel(news: news), at: 0)
                appState.upSliderPageState = .NONE
            case .failure(let error):
                appState.postListState.postNewsError = error
                print("[ERROR]: \(error.localizedDescription)")
            }
        
        case .postBlog:
            guard !appState.postState.isPosting else{
                break
            }
            appState.postState.isPosting = true
            appCommand = PostBlogAppCommand(
                userId: appState.loginState.user!.id,
                blogUrl: appState.postState.blogURL,
                privilege: 1, tags: "[111]")
            
        case .postBlogDone(let result):
            appState.postState.isPosting = false
            switch result {
            case .success(let blog):
                appState.postListState.postListViewModel.blogList.insert(BlogViewModel(blog: blog), at: 0)
                appState.upSliderPageState = .NONE
            case .failure(let error):
                appState.postListState.postBlogError = error
                print("[ERROR]: \(error.localizedDescription)")
            }
        
        case .verifyRegisterCode:
            guard !appState.loginState.isVerifing else{
                break
            }
            appState.loginState.isVerifing = true
            appCommand = VerifyRegisterCodeAppCommand(registerCode: appState.loginState.registerAccountChecker.registerCode)
            
        case .verifyRegisterCodeDone(let result):
            appState.loginState.isVerifing = false
            switch result {
            case .success(let clubName):
                appState.loginState.registerAccountChecker.isRegisterCodeValid = true
                appState.loginState.registerAccountChecker.validClubName = clubName
            case .failure(let error):
                appState.loginState.isRegisterEmailValid = false
                print(error)
            }
        }
        
        return (appState, appCommand)
    }
      
}
