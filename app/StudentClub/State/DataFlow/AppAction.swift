//
//  AppAction.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import LinkPresentation

enum AppAction {
    
    case loginEmailValid(valid: Bool)
    case registerEmailValid(valid: Bool)
    
    // MARK: Login
    case input
    case inputDone
    
    case verifyRegisterCode
    case verifyRegisterCodeDone(result: Result<String, AppError>)
    case login(emai: String, password: String)
    case loginAsGuest
    case accountBehaviorDone(result: Result<User, AppError>)
    case logout
    case register
    case registerDone(result: Result<String, AppError>)
    
    // MARK: Loading
    case loadNews
    case loadNewsDone(result: Result<[News], AppError>)
    case loadBlog
    case loadBlogDone(result: Result<[Blog], AppError>)
    case loadBlogLPMetaData(index: Int)
    case loadBlogLPMetaDataDone(blogIndex: Int, result: Result<LPLinkMetadata, AppError>)
    case loadPostingBlogLPMetaData
    case loadPostingBlogLPMetaDataDone(result: Result<LPLinkMetadata, AppError>)
    case loadEvents
    case loadEventsDone(result: Result<[Event], AppError>)
    
    case loadClubList
    case loadClubListDone(result: Result<[ClubInfo], AppError>)
    case loadMyClubMembers
    case loadMyClubMembersDone(result: Result<(UserInfo, UserInfo, [UserInfo]), AppError>)
    case loadUserDetail(userID: Int)
    case loadUserDetailDone(result: Result<User, AppError>)
    case loadClubDetail(clubCode: Int)
    case loadClubDetailDone(result: Result<Club, AppError>)
    case loadUserDetailForMainTab
    case loadUserDetailForMainTabDone(result: Result<User, AppError>)
    
    case loadNewsHistory
    case loadNewsHistoryDone(result: Result<[News], AppError>)
    case loadBlogHistory
    case loadBlogHistoryDone(result: Result<[Blog], AppError>)

    case postNews
    case postNewsDone(result: Result<News, AppError>)
    case postBlog
    case postBlogDone(result: Result<Blog, AppError>)
    
    case deleteClubMember(index: Int)
    case deleteClubMemberDone(result: Result<(UserInfo, UserInfo, [UserInfo]), AppError>)
    
    case presentEditEventModal
    case publishEvent(requestEvent: PublishEventRequest.RequestBody)
    case publishEventDone(result: Result<Event, AppError>)
    
    case editProfileInfo(target: EditProfileInfoRequest.EditTarget, param: String)
    case editProfileInfoDone(target: EditProfileInfoRequest.EditTarget, result: Result<User, AppError>)
    
    case pqEvent(action: PQEventRequest.Action, eventId: Int)
    case pqEventDone(action: PQEventRequest.Action, result: Result<Event, AppError>)
    

    
    
    
    
    // MARK: UI Event
    case clickDayCell(day: EDayViewModel)
    case clickNewsCell(news: NewsViewModel)
    case closeNewsDetail
    
    case selectMonth(month: Int)
    case nextPage
    case lastPage
}
