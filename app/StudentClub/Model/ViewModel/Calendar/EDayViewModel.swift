//
//  EDayViewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import SwiftUI

enum EDayState: Int8, Hashable{
    case uncover, available, selected, unavailable
}

class EDayViewModel: Identifiable{
    var size: CGSize {
        CGSize.init(width: 38, height: 38)
    }
    
    var backGroundColor: Color {
        switch self.state {
        case .uncover: return Color("Base")
        case .available: return Color("Base")
        case .selected: return Color.red
        case .unavailable: return Color("Base")
        }
    }
    
    var fontColor: Color{
        switch self.state {
        case .uncover: return Color.gray
        case .available: return Color.black
        case .selected: return Color.white
        case .unavailable: return Color.black
        }
    }
    
    var model: EDay
    var state: EDayState
    var events = [Event]()
    
    init(model: EDay, state: EDayState) {
        self.model = model
        self.state = state
    }
}

extension EDayViewModel{
    func getStringDate() -> String{
        return String(self.model.date)
    }
}

extension EDayViewModel: Equatable{
    static func == (lhs: EDayViewModel, rhs: EDayViewModel) -> Bool {
        return (lhs.model == rhs.model)
    }
}
