//
//  User.swift
//  StudentClub
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
    var name: String
    var avatar: String
    //TODO: var gender: Gender
    var gender: String
    var description: String
    var clubInfo: ClubInfo
    var userPrivilege: Int
    
    var loginEmail: String
    var password: String
    
    var contactEmail: String
    var phoneNumber: String
    
    struct ClubInfo: Codable {
        var clubCode: Int
        var clubName: String
        var clubAvatar: String
    }
}

extension User{
    static func defaultUser() -> User{
        return User(
            id: -1, name: "123",
            avatar: "", gender: "Male",
            description: "",
            clubInfo: ClubInfo(clubCode: 0, clubName: "TJ", clubAvatar: ""),
            userPrivilege: -1,
            loginEmail: "", password: "",
            contactEmail: "", phoneNumber: "")
    }
}
