//
//  Event.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct Event: Codable, Hashable {
    var id: Int
    var title: String
    var startDate: String
    var endDate: String
    var location: String
    var url: String
    var notes: String
    var clubCode: Int
    var participant: String
    var openOrNot: Int
    
    func isParticipated(userId: Int) -> Bool {
        let participantArray =
            self.participant
                .dropFirst().dropLast()
                .split(separator: ",")
                .map(String.init)
                .map{$0.trimmingCharacters(in: CharacterSet.whitespaces)}
                .map{Int($0)}
        return participantArray.contains(userId)
    }
}
