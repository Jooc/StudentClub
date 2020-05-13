//
//  Event.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct Event: Codable, Hashable{
    var date: String
    
    var title: String
//    var content: String
//    var location: String?
}


struct Event_Pro {
    struct Sys_Data {
        var title: String
        var start_date: Date
        var end_date: Date
        var location: String
        
        var All_day: Bool
        var Invitees: [String]
        var alert: Bool
        var notes: String
    }
    
    var initiator: User
    var user_privilege: Int
    var university: University
    
    var participants: [User]
    
    var data: Sys_Data
}
