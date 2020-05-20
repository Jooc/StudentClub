//
//  EventCell.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct EventCell: View {
    @EnvironmentObject var store: Store
    
    var index: Int
    var event: Event?{
        if self.store.appState.eventState.selectedDay?.events.count != 0{
            return self.store.appState.eventState.selectedDay?.events[index]
        }
        return nil
    }
    
    var participated: Bool{
        if self.store.appState.eventState.selectedDay != nil{
            return (self.store.appState.eventState.selectedDay?.events[self.index].isParticipated(
                userId: self.store.appState.loginState.user?.id ?? 0))!
        }
        return false
    }
    
    var body: some View {
        VStack {
            if event != nil{
                HStack(spacing: 10) {
                    switchButton
                        .onTapGesture {
                            if !self.store.appState.eventState.isPQing{
                                if self.participated{
                                    self.store.dispatch(.pqEvent(action: .Quit, eventId: self.event!.id))
                                }else{
                                    self.store.dispatch(.pqEvent(action: .Participate, eventId: self.event!.id))
                                }
                            }
                    }
                    
                    VStack(alignment: .leading, spacing: 8){
                        Text(event!.title)
                            .font(.headline)
                        Text(event!.startDate)
                            .font(.caption)
                            .foregroundColor(Color.gray)
                    }
                }
            }
//            Button("Button"){
//                self.participated.toggle()
//            }.padding(.top, 100)
        }
    }
    
    var switchButton: some View{
        ZStack{
            Image(systemName: "flag.fill")
                .foregroundColor(Color.green)
                .font(.system(size: 30, weight: .bold))
                .offset(x: self.participated ? 0:90, y: self.participated ? 0:90)
                .rotation3DEffect(Angle(degrees: self.participated ? 0:30), axis: (x: 10, y: -10, z: 0))
            Image(systemName: "flag.slash.fill")
                .foregroundColor(Color.red)
                .font(.system(size: 30, weight: .bold))
                .offset(x: self.participated ? -90:0, y: self.participated ? -90:0)
                .rotation3DEffect(Angle(degrees: self.participated ? 30:0), axis: (x: -10, y: 10, z: 0))
        }
        .frame(width: 60, height: 60)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(20)
        .animation(.spring())
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        EventCell(index: 0).environmentObject(Store.Sample())
    }
}
