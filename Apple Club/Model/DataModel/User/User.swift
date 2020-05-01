//
//  User.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var userName: String
    var avatar: String
    var description: String
    var universityCode: Int
    var userPrivilege: Int
    
    var loginEmail: String
    var password: String
    
    var contactEmail: String
    var phoneNumber: String
}

extension User{
    static func defaultUser() -> User{
        return User(
            id: -1, userName: "123",
            avatar: "", description: "",
            universityCode: -1, userPrivilege: -1,
            loginEmail: "", password: "",
            contactEmail: "", phoneNumber: "")
    }
}
