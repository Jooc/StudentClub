//
//  User.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

enum Gender: CaseIterable{
    case undefined, Male, Female
    
    var text: String{
        switch self {
        case .undefined: return "未定义"
        case .Male: return "男"
        case .Female: return "女"
        }
    }
}

struct User: Codable {
    var id: Int
    var userName: String
    var avatar: String
    //TODO: var gender: Gender
    var gender: String
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
            avatar: "", gender: "Male",
            description: "",
            universityCode: -1, userPrivilege: -1,
            loginEmail: "", password: "",
            contactEmail: "", phoneNumber: "")
    }
}
