//
//  StudentClubActionTests.swift
//  StudentClubActionTests
//
//  Created by 齐旭晨 on 2020/5/22.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import XCTest
@testable import StudentClub

class StudentClubActionTests: XCTestCase {
    var store: StudentClub.Store!

    override func setUp() {
        super.setUp()
        store = Store()
    }
    
    override func tearDown() {
        super.tearDown()
        store = nil
    }
    
    func testRegister() {
        store.appState.loginState.registerAccountChecker.registerCode = "CY3E2O8WIL"
        store.dispatch(.verifyRegisterCode)

        store.appState.loginState.registerAccountChecker.loginEmail = "111@11.com"
        store.appState.loginState.registerAccountChecker.userName = "TestName"
        store.appState.loginState.registerAccountChecker.password = "123456"
        store.appState.loginState.registerAccountChecker.verifyPassword = "123456"
        store.dispatch(.register)
    }
    
    func testLoginAction() throws{
        let email = "111@11.com"
        let password = "123456"
        store.dispatch(.login(emai: email, password: password))
        store.dispatch(.logout)
    }
    
    func testLoadActions() throws{
//        store.dispatch(.login(emai: "111@11.com", password: "123456"))
        
        store.dispatch(.loadNews)
        store.dispatch(.loadBlog)
        store.dispatch(.loadEvents)
        store.dispatch(.loadClubList)
        store.dispatch(.loadMyClubMembers)
        store.dispatch(.loadNewsHistory)
        store.dispatch(.loadBlogHistory)
        
    }
    
    func testEditProfileActions() throws {
        store.dispatch(.editProfileInfo(target: .name, param: "NewTestName"))
        store.dispatch(.editProfileInfo(target: .gender, param: "Male"))
        store.dispatch(.editProfileInfo(target: .contactEmail, param: "test@test.com"))
        store.dispatch(.editProfileInfo(target: .phoneNumber, param: "11111111111"))
    }
    
    func pqEventActions() throws {
        store.dispatch(.pqEvent(action: .Participate, eventId: 1))
        store.dispatch(.pqEvent(action: .Quit, eventId: 1))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
