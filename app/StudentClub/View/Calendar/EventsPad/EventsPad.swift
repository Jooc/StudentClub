//
//  EventsPad.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct EventsPad: View {
    @EnvironmentObject var store: Store
    
    var selectDay: EDayViewModel?{
        self.store.appState.eventState.selectedDay
    }
    
    var body: some View {
        VStack{
            if selectDay != nil{
                List{
                    ForEach(selectDay!.events, id: \.self){ event in
                        EventCell(index: (self.selectDay?.events.firstIndex(of: event))!)
                            .padding(.vertical, 5)
                    }
                }
            }
        }
    }
}

struct EventsPad_Previews: PreviewProvider {
    static var previews: some View {
        EventsPad().environmentObject(Store.Sample())
    }
}
