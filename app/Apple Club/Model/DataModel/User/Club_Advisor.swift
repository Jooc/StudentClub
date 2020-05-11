//
//  Club_Advisor.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct Club_Advisor: User {
    // what happens after inherting
    var id: Int
    var name: String
    var avatar: String?
    var login_email: String
    var login_password: String
    
    var university: University
    var contact: Contact
}
