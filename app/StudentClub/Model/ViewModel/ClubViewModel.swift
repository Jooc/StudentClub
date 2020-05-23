//
//  ClubViewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

class ClubViewModel {
    @Published var clubs = [ClubInfo]()
    
    @Published var myAdvisor = UserInfo(id: -1, name: "", avatar: "", privilege: 0)
    @Published var myManager = UserInfo(id: -1, name: "", avatar: "", privilege: 0)
    @Published var myClubMembers = [UserInfo]()
    
    init() {
        
    }
    
    func resetClubs(clubInfoList: [ClubInfo]) {
        self.clubs = clubInfoList
    }
    
    func resetMyClubMembers(userList: (UserInfo, UserInfo, [UserInfo])){
        self.myAdvisor = userList.0
        self.myManager = userList.1
        self.myClubMembers = userList.2
    }
}
