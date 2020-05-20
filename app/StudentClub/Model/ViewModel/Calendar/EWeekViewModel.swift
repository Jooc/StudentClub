//
//  EWeekViewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import SwiftUI

class EWeekViewModel: Identifiable, Hashable {
    func hash(into hasher: inout Hasher) { }
    static func ==(lhs: EWeekViewModel, rhs: EWeekViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id = UUID()
    var space: CGFloat = 18
    
    @Published var days: [EDayViewModel]
    
    init() {
        days = [EDayViewModel]()
    }
}
