//
//  Guest.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct Guest: User {
    var id: Int
    var name: String = "guest"
    var avatar: String? = nil
    
    var login_email: String
    var login_password: String
}
