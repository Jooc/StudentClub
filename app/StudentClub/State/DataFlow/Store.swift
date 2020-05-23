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
            case .failure(let error):
                appState.postListState.loadNewsError = error
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
        case .loadEvents:
            guard !appState.eventState.isLoading else{
                break
            }
            appState.eventState.isLoading = true
            appCommand = LoadEventsAppCommand(userId: appState.loginState.user?.id ?? 0)
        case .loadEventsDone(let result):
            appState.eventState.isLoading = false
            switch result {
            case .success(let events):
                appState.eventState.calendarViewModel.updateEvents(with: events, userID: appState.loginState.user?.id ?? 0)
            case .failure(let error):
                appState.eventState.loadEventError = error
                print("[ERROR]: \(error.localizedDescription)")
            }
            
        case .loadClubList:
            appCommand = LoadClubListAppCommand()
        case .loadClubListDone(let result):
            switch result {
            case .success(let clubList):
                appState.clubState.viewModel.resetClubs(clubInfoList: clubList)
            case .failure(let error):
                appState.clubState.loadError = error
            }
        case .loadMyClubMembers:
            appCommand = LoadMyClubMembersAppCommand(clubCode: appState.loginState.user?.clubInfo.clubCode ?? -1)
        case .loadMyClubMembersDone(let result):
            switch result {
            case .success(let memberList):
                appState.clubState.viewModel.resetMyClubMembers(userList: memberList)
            case .failure(let error):
                appState.clubState.loadError = error
            }
            
        case .loadNewsHistory:
            appCommand = LoadNewsHistoryAppCommand(userId: appState.loginState.user?.id ?? 0)
        case .loadNewsHistoryDone(let result):
            switch result {
            case .success(let newsList):
                appState.postHistoryState.viewModel.updateNews(newsList: newsList)
            case .failure(let error):
                appState.postHistoryState.loadHistoryError = .networkFailed(error)
                print("[ERROR]: \(error.localizedDescription)")
            }
        case .loadBlogHistory:
            appCommand = LoadBlogHistoryAppCommand(userId: appState.loginState.user?.id ?? 0)
        case .loadBlogHistoryDone(let result):
            switch result {
            case .success(let blogList):
                appState.postHistoryState.viewModel.updateBlog(blogList: blogList)
            case .failure(let error):
                appState.postHistoryState.loadHistoryError = .networkFailed(error)
                print("[ERROR]: \(error.localizedDescription)")
            }
            
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
            
        case .deleteClubMember(let index):
            guard !appState.clubState.isDeleting else{
                break
            }
            appCommand = DeleteClubMemberAppCommand(
                requestBody: DeleteClubMemberRequest.RequestBody(
                    clubCode: (appState.loginState.user?.clubInfo.clubCode)!,
                    targetMemberId: appState.clubState.viewModel.myClubMembers[index].id))
        case .deleteClubMemberDone(let result):
            switch result{
            case .success(let userList):
                appState.clubState.viewModel.resetMyClubMembers(userList: userList)
            case .failure(let error):
                appState.clubState.deleteError = error
            }
            
        case .presentEditEventModal:
            appState.eventState.presentCalendarModalToAddEvent()
        case .publishEvent(let requestBody):
            guard !appState.eventState.isPublishing else{
                break
            }
            appState.eventState.isPublishing = true
            appCommand = PublishEventAppCommand(requestBody: requestBody)
        case .publishEventDone(result: let result):
            appState.eventState.isPublishing = false
            switch result {
            case .success(let event):
                appState.eventState.calendarViewModel.updateEvents(with: [event], userID: appState.loginState.user?.id ?? 0)
            case .failure(let error):
                appState.eventState.publishEventErrpr = error
                print("[ERROR]: \(error.localizedDescription)")
            }
            
        case .editProfileInfo(let target, let param):
            let userId = appState.loginState.user?.id ?? 0
            appCommand = EditProfileInfoAppCommand(target: target, userId: userId, param: param)
            
        case .editProfileInfoDone(let target, let result):
            switch result {
            case .success(let user):
                switch target {
                case .name:
                    appState.loginState.user?.name = user.name
                    appState.meState.editUserName = false
                case .gender:
                    appState.loginState.user?.gender = user.gender
                //                    appState.meState.edit
                case .phoneNumber:
                    appState.loginState.user?.phoneNumber = user.phoneNumber
                    appState.meState.editPhoneNumber = false
                case .contactEmail:
                    appState.loginState.user?.contactEmail = user.contactEmail
                    appState.meState.editContactEmail = false
                }
                
            case .failure(let error):
                appState.meState.editError = error
            }
        case .pqEvent(let action, let eventId):
            appCommand = PQEventAppCommand(
                action: action,
                eventId: eventId,
                userId: appState.loginState.user?.id ?? 0)
            
        case .pqEventDone(let action, let result):
            switch result {
            case .success(let event):
                appState.eventState.calendarViewModel.updateSingleEventParticipant(with: event, userId: appState.loginState.user?.id ?? 0)
                switch action {
                case .Participate:
                    appState.eventState.selectedDayPreState = .participated
                case .Quit:
                    for event in appState.eventState.selectedDay!.events{
                        if event.isParticipated(userId: appState.loginState.user!.id){
                            appState.eventState.selectedDayPreState = .participated
                            break
                        }
                        appState.eventState.selectedDayPreState = .available
                    }
                }
            case .failure(let error):
                appState.eventState.pqEventError = error
            }
            
        case .clickDayCell(let day):
            appState.eventState.clickDayCell(dayViewModel: day)
        case .clickNewsCell(let news):
            appState.postListState.showNewsDetail(news: news)
        case .closeNewsDetail:
            appState.postListState.detailedNews = nil
        case .nextPage:
            appState.eventState.nextMonth()
        case .lastPage:
            appState.eventState.lastMonth()
        case .selectMonth(let month):
            appState.eventState.currentMonth = month
        }
        return (appState, appCommand)
    }
}
