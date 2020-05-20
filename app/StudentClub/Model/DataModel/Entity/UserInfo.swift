//
//  UserInfo.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/25.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct UserInfo: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var avatar: String
    var privilege: Int
}
