//
//  File.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct Club: Codable {
    var code: Int
    var name: String
    var icon: String
    var description: String
    var advisor: UserInfo
    var manager: UserInfo
    var members: [UserInfo]
}

extension Club{
    static func defaultClub() -> Club{
        return Club(code: -1, name: "", icon: "", description: "",
                    advisor: UserInfo(id: -1, name: "", avatar: "", privilege: -1),
                    manager: UserInfo(id: -1, name: "", avatar: "", privilege: -1),
                    members: [UserInfo]())
    }
}


struct ClubInfo: Codable {
    var code: Int
    var name: String
    var icon: String

    init(club: Club) {
        self.code = club.code
        self.name = club.name
        self.icon = club.icon
    }
    
    static func transferClubs2ClubInfos(clubList: [Club]) -> [ClubInfo]{
        return clubList.map{ClubInfo(club: $0)}
    }
}
