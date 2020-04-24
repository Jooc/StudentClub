//
//  User.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct User: Codable {
    var userPrivilege: Int
    var username: String
    var email: String
    var avatar: String
    var position: String
    var description: String
    var university: University
    var password: String
}

struct User_New: Codable {
    var id: Int
    var user_name: String
    var avatar: String?
    var description: String
    
    var contact: Contact
    var university: University
    
    var user_privilege: Int
    var login_email: String
//    var login_password: String
}
