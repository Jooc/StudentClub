//
//  UpSlider.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/17.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct UpSlider: View {
    @EnvironmentObject var store: Store
    var showWhich: AppState.UpSliderPageState{
        self.store.appState.upSliderPageState
    }
    
    var body: some View {
        ZStack{
            Color.white.edgesIgnoringSafeArea(.all)
            
            if showWhich == .postNews{
                PostNewsPage()
            }else if showWhich == .postBlog{
                PostBlogPage()
            }
        }
    }
}

struct UpSlider_Previews: PreviewProvider {
    static var previews: some View {
        UpSlider().environmentObject(Store())
    }
}
