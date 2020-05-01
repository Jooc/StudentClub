//
//  NewsListViewModel.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/25.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct NewsListViewModel {
    var newsList = [NewsViewModel]()
}

extension NewsListViewModel{
    mutating func updateNews(newsList: [News]){
        self.newsList.removeAll()
        for news in newsList{
            self.newsList.append(NewsViewModel(news: news))
        }
    }
}
