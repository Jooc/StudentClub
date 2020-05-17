//
//  AppState.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine
import Alamofire
import SwiftUI

struct AppState{
    enum UpSliderPageState {
        case postNews, postBlog, NONE
    }
    enum RightSliderPageState{
        case newsDetail, profile, newsBase, blogBase, clubInfo, clubList, NONE
    }
    
    var loginState = LoginState()
    var postListState = PostListState()
    var postState = PostState()
    var meState = MeState()
    var calendarState = CalendarState()
    
    var showMe = true
    
//    var showPostNewsPage = false
    var showDetailedNews = false
    var upSliderPageState: UpSliderPageState = .NONE
    var rightSliderPageState: RightSliderPageState = .NONE
    
    init() {
    }
}

extension AppState{
        struct LoginState{
            @FileStorage(directory: .documentDirectory, fileName: "user.json")
             var user: User?
            
            enum LoginBehavior {
                case login, register
            }
            var loginBehavior = LoginBehavior.login
            
            var isInputting = false
            var isLogining = false
            var isVerifing = false
            var isRegistering = false
            
            var loginError: AppError?
            var registerError: AppError?
            
            var loginAccountChecker = LoginAccountChecker()
            var registerAccountChecker = RegisterAccountChecker()
            var isLoginEmailValid: Bool = false
            var isRegisterEmailValid: Bool = false
            
            class LoginAccountChecker {
                @Published var email = ""
                @Published var password = ""
                
                var isEmailValid: AnyPublisher<Bool, Never>{
                    $email.map{ $0.isValidEmailAddress }.eraseToAnyPublisher()
                }
            }
            
            class RegisterAccountChecker {
                @Published var registerCode = ""
                @Published var loginEmail = ""
                @Published var userName = ""
                @Published var password = ""
                @Published var verifyPassword = ""
                
                @Published var isRegisterCodeValid: Bool = false
                @Published var validClubName: String = ""
                
                var isEmailValid: AnyPublisher<Bool, Never>{
                    $loginEmail.map{ $0.isValidEmailAddress }.eraseToAnyPublisher()
                }
            }
        }
}

extension AppState{
    struct PostListState {
        var postListViewModel  = PostListViewModel(date: "2020-5-17")
        
        var showAddButtons = false
        
        var detailedNews: NewsViewModel? = nil
        var isLoading = false
        var loadNewsError: AppError?
        var postNewsError: AppError?
        var postBlogError: AppError?
        
        mutating func showNewsDetail(news: NewsViewModel) {
            self.detailedNews = news
        }
    }
}

extension AppState{
    struct PostState {
        var isPosting: Bool = false
        
        var showCamera = false
        var showPhotoLibrary = false
        
        var pickImageActionSheet = false
        
        var title: String = ""
        var content: String = ""
        var tags: String = ""
        var privilege: Int = 0
        var image: UIImage?
        
        var blogURL: String = ""
    }
}

extension AppState{
    struct MeState{
        var viewModel = MeViewModel()
        
        var closed = false
        
        var isProfileActive = false
        var isNewsPostActive = false
        var isBlogPostActive = false
        var isClubInfoActive = false
        var isClubListActive = false
        
        var editAvatar: Bool = false
        var editUserName: Bool = false
        var editPhoneNumber: Bool = false
        var editContactEmail: Bool = false
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
