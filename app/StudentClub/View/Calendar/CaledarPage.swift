//
//  CaledarPage.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct CalendarPage: View {
    @EnvironmentObject var store: Store
    
    var selectedDay: EDayViewModel?{
        self.store.appState.eventState.selectedDay
    }
    
    var body: some View {
        ZStack(alignment: .top) {
        
                VStack(spacing: 0){
                    CalendarHeader()
                    CalendarPad()
                    EventsPad()
                }

            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {self.store.dispatch(.presentEditEventModal)}){
                        CircleButton(icon: "calendar.badge.plus")
                            .padding(15)
                    }
                    .offset(x: self.selectedDay == nil ? 150 : 0)
                    .sheet(isPresented: self.$store.appState.eventState.showEditView){
                        EventKitUIView(
                            isPresented: self.$store.appState.eventState.showEditView,
                            eventStore: self.$store.appState.eventState.eventStore
                        ).environmentObject(self.store)
                    }
                    .animation(.spring())
                }
            }
        }
    }
}

struct CalendarPage_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPage().environmentObject(Store.Sample())
    }
}
