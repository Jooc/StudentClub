//
//  RightSlider.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct RightSlider: View {
    @EnvironmentObject var store: Store
    
    var showWhich: AppState.RightSliderPageState{
        self.store.appState.rightSliderPageState
    }
    
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            if showWhich == .profile{
                ProfileInfo()
            }else if showWhich == .newsBase{
                NewsPostHistory()
            }else if showWhich == . blogBase{
                BlogPostHistory()
            }
        }
    }
}

struct RightSlider_Previews: PreviewProvider {
    static var previews: some View {
        RightSlider().environmentObject(Store.Sample())
    }
}
