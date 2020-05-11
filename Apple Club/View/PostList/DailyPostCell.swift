//
//  DailyPostCell.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/5/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct DailyPostCell: View {
    @EnvironmentObject var store: Store
    var dailyPostIndex: Int
    
    var viewModel: DailyPostViewModel{
        self.store.appState.postListState.postListViewModel.dailyPostList[dailyPostIndex]
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text(viewModel.date)
            
            ForEach(viewModel.newsList.indices){index in
                NewsCell(newsIndex: (self.dailyPostIndex, index))
            }
            ForEach(viewModel.blogList.indices){index in
                BlogCell(blogIndex: (self.dailyPostIndex, index))
            }
        }
    }
}

struct DailyPostCell_Previews: PreviewProvider {
    static var previews: some View {
        DailyPostCell(dailyPostIndex: 0)
    }
}
