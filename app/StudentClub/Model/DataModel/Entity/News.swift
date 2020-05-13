//
//  News.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct News: Codable {
    var id: Int
    var postTime: String
    
    var title: String
    var content: String
    var images: [String]
    
    var newsPublisher: UserInfo
    var newsPrivilege: Int
    
    var tags: [String]
}
