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
import EventKit

struct AppState{
    enum UpSliderPageState {
        case postNews, postBlog, NONE
    }
    enum RightSliderPageState{
        case newsDetail, profile, newsBase, blogBase, NONE
    }
    
    var loginState = LoginState()
    var postListState = PostListState()
    var postState = PostState()
    var meState = MeState()
    var clubState = ClubState()
    var eventState = EventState()
    var postHistoryState = PostHistoryState()
    
    var showMe = true
    var showAddButtons = false
    
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
    class PostListState {
        @Published var postListViewModel  = PostListViewModel(date: "2020-5-17")
        
        @Published var detailedNews: NewsViewModel? = nil
        
        var isLoading = false
        @Published var loadNewsError: AppError?
        @Published var postNewsError: AppError?
        @Published var postBlogError: AppError?
        
        func showNewsDetail(news: NewsViewModel) {
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

        var isClubInfoActive = false
        var isClubListActive = false
        
        var editAvatar: Bool = false
        var editUserName: Bool = false
        var editGender: Bool = false
        var editPhoneNumber: Bool = false
        var editContactEmail: Bool = false
        
        var newAvatar: UIImage?
        var newName: String = ""
        var newGender: String = ""
        var newPhoneNumber: String = ""
        var newContactEmail: String = ""
        
        var editError: AppError?
    }
}

extension AppState{
    class PostHistoryState{
        @Published var viewModel = PostHistoryViewModel()
        
        var loadHistoryError: AppError?
    }
}

extension AppState{
    struct ClubState{
        var viewModel = ClubViewModel()
        
        var isDeleting: Bool = false
        
        var loadError: AppError?
        var deleteError: AppError?
    }
}

extension AppState{
    class EventState{
        @Published var calendarViewModel = CalendarViewModel()
        
        var monthCount = 12
        var isLoading = false
        var isPublishing = false
        var isPQing = false
        var newEventOpenOrNot = 1
        
        @Published var loadEventError: AppError?
        @Published var publishEventErrpr: AppError?
        @Published var pqEventError: AppError?
        
        @Published var currentMonth: Int = 5
        @Published var selectedDay: EDayViewModel? = nil
        @Published var selectedDayPreState: EDayState = .uncover
        
        var eventStore = EKEventStore()
        @Published var showEditView: Bool = false
        
        func presentCalendarModalToAddEvent() {
            let authStatus = getAuthorizationStatus()
            print(authStatus.rawValue)
            
            switch authStatus {
            case .authorized:
                self.showEditView = true
                print("EditView Showed")
            case .notDetermined:
                self.eventStore.requestAccess(to: .event) { (accessGranted, error) in
                    if accessGranted {
                        self.showEditView = true
//                        print("Showed")
                    } else {
                        // TODO: Show Alert
                        self.publishEventErrpr = AppError.haveNoAccess
                        print("Access Denied")
                    }
                }
            case .denied, .restricted:
                self.publishEventErrpr = AppError.haveNoAccess
                print("Access Denied")
            @unknown default:
                print("Unknown Case")
            }
        }
        
        func getAuthorizationStatus() -> EKAuthorizationStatus {
            return(EKEventStore.authorizationStatus(for: .event))
        }
        
        func clickDayCell(dayViewModel: EDayViewModel) {
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
//            print(selectedDay?.getStringDate() ?? "EMPTY")
        }
        
        func nextMonth(){
            if currentMonth == 12{
                return
            }
            currentMonth += 1
        }
        
        func lastMonth() {
            if currentMonth == 1{
                return
            }
            self.currentMonth -= 1
        }
    }
}

