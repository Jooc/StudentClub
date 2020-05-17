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
    case login(emai: String, password: String)
    case accountBehaviorDone(result: Result<User, AppError>)
//    case accountBehaviorDone(result: Result<UserResponse, AppError>)
    case logout
    case register
    case registerDone(result: Result<String, AppError>)
    
    // MARK: Loading
    case loadNews
    case loadNewsDone(result: Result<[News], AppError>)
    case loadBlog
    case loadBlogDone(result: Result<[Blog], AppError>)
    
    case loadEvents
    case loadEventsDone(result: Result<[Event], AppError>)
    case loadBlogLPMetaData(index: Int)
    case loadBlogLPMetaDataDone(blogIndex: Int, result: Result<LPLinkMetadata, AppError>)
    
    // MARK: UI Event
    case clickDayCell(day: EDayViewModel)
    case clickNewsCell(news: NewsViewModel)
    case closeNewsDetail
    
    case selectMonth(month: Int)
    case nextPage
    case lastPage
    
    case postNews
    case postNewsDone(result: Result<News, AppError>)
    case postBlog
    case postBlogDone(result: Result<Blog, AppError>)
    
    case verifyRegisterCode
    case verifyRegisterCodeDone(result: Result<String, AppError>)
}
