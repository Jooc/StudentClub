//
//  News.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct News: Codable, Hashable{
    var id: Int
    var postTime: String
    
    var title: String
    var content: String
    var images: [String]
    
    var publisherInfo: UserInfo
    var privilege: Int
    
    var tags: String
}

extension News{
    func cutPostTime() -> String {
        return String(postTime.split(separator: " ")[0])
    }
}
