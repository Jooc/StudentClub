//
//  News.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct News: Codable {
    struct NewsPublisher: Codable {
        var username: String
        var email: String?
        var avatar: String
        var position: String
    }

    var id: Int
    var time: String
    var title: String
    var user: NewsPublisher

    var images: [String]?
    var video: String?
    var content: String

    var tags: [String]
    var newsPrivilege: Int
}
