//
//  Blog.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/5/3.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct Blog: Codable {
    var id: Int
    var postTime: String
    
    var url: String
    
    var blogPublisher: UserInfo
    var blogPrivilege: Int
    
    var tags: [String]
}
