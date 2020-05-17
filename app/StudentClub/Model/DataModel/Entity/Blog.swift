//
//  Blog.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/3.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct Blog: Codable, Hashable {
    var id: Int
    var postTime: String
    
    var url: String
    
    var publisherInfo: UserInfo
    var privilege: Int
    
    var tags: String
}
