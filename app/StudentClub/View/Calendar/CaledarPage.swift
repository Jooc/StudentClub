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
    @State var showAddPage = false
    
    var selectedDay: EDayViewModel?{
        self.store.appState.calendarState.selectedDay
    }
    
    var body: some View {
        VStack(spacing: 0){
            VStack(spacing: 0){
                CalendarHeader()
                CalendarPad()
            }
            ZStack {
                if self.selectedDay != nil{
                    VStack{
                        List(selectedDay!.events, id:\.self){event in
                            Text(event.title)
                        }
                    }
                    .frame(width: screen.width)
                    .frame(maxHeight: .infinity)
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {self.showAddPage.toggle()}){
                            CircleButton(icon: "calendar.badge.plus")
                                .padding(.trailing, 15)
                        }
                        .offset(x: self.selectedDay == nil ? 150 : 0)
                        .sheet(isPresented: $showAddPage){
                            Text("123")
                        }
                        .animation(.spring())
                    }
                }
            }
            Spacer()
        }
    }
}

struct CalendarPage_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPage().environmentObject(Store())
    }
}
