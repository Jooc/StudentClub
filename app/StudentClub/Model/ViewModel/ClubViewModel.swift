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
    @Published var myClubMembers = [UserInfo]()
    
    init() {
        
    }
    
    func resetClubs(clubInfoList: [ClubInfo]) {
        self.clubs = clubInfoList
    }
    
    func resetMyClubMembers(userInfoList: [UserInfo]){
        self.myClubMembers = userInfoList
    }
}
