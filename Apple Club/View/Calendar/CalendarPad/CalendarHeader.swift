//
//  CalendarHeader.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct CalendarHeader: View {
    @EnvironmentObject var store: Store
    
    var currentMonth: Int{
        self.store.appState.calendarState.currentMonth
    }
    
    var screen = UIScreen.main.bounds
    
    var body: some View {
        HStack(spacing: 30){
//            Button(action: {
//                self.store.dispatch(.lastPage)
//            }){
//                Image(systemName: "chevron.left")
//            }
            Text(MonthSymbol(rawValue: currentMonth)!.text)
                .frame(width: screen.width*0.3)
//            Button(action: {
//                self.store.dispatch(.nextPage)
//            }){
//                Image(systemName: "chevron.right")
//            }
        }
        .frame(width: screen.width, height: 50)
    }
}

struct CalendarHeader_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHeader().environmentObject(Store())
    }
}
