//
//  CalendarPad.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct CalendarPad: View {
    @EnvironmentObject var store: Store
    
    var activePageIndex: Int{
        self.store.appState.calendarState.currentMonth - 1
    }

    var itemCount: Int{
        self.store.appState.calendarState.monthCount
    }
    
    @State var currentScrollOffset: CGFloat = 0
    @State var dragOffset: CGFloat = 0
    
    func pageIndexForOffset(offset: CGFloat) -> Int{
        guard self.store.appState.calendarState.monthCount>0 else{
            return 0
        }
        
        let floatIndex = (self.logicalScrollOffset(trueOffset: offset))/(screen.width)
        var computedIndex = Int(round(floatIndex))
        computedIndex = max(computedIndex, 0)
        return min(computedIndex, self.store.appState.calendarState.monthCount-1)
    }
    
    func offsetForPageIndex(_ index: Int)->CGFloat {
        let activePageOffset = CGFloat(index)*(screen.width)
        return 0 - activePageOffset
    }
    
    func computeScrollOffset() -> CGFloat{
        return self.offsetForPageIndex(self.store.appState.calendarState.currentMonth - 1) + self.dragOffset
    }
    
    func logicalScrollOffset(trueOffset: CGFloat) -> CGFloat{
        return (trueOffset) * -1
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(alignment: .top, spacing: 0){
                ForEach(self.store.appState.calendarState.calendarViewModel.months){month in
                    VStack {
                        MonthPad(viewModel: month)
                            .padding(.vertical)
                    }
                }
            }
            .onAppear{
                self.currentScrollOffset = self.offsetForPageIndex(self.store.appState.calendarState.currentMonth - 1)
            }
            .background(Color("Base"))
            .offset(x: self.currentScrollOffset)
            .simultaneousGesture(
                DragGesture(minimumDistance: 1, coordinateSpace: .local)
                    .onChanged{ value in
                        self.dragOffset = value.translation.width
                        self.currentScrollOffset = max(min(0, self.computeScrollOffset()), screen.width*(-11))
                }
                .onEnded{ value in
                    let velocityDiff = (value.predictedEndTranslation.width - self.dragOffset)
                    print(velocityDiff)
                    let newPageindex = self.pageIndexForOffset(offset: self.currentScrollOffset + velocityDiff)
                    self.dragOffset = 0
                    withAnimation(.spring()){
                        self.store.dispatch(.selectMonth(month: newPageindex + 1))
                        self.currentScrollOffset = self.offsetForPageIndex(newPageindex)
                    }
                }
            )
        }
    }
}

struct CalendarPad_Previews: PreviewProvider {
    static var previews: some View {
        CalendarPad().environmentObject(Store())
    }
}
