//
//  PostHistoryViewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

class PostHistoryViewModel{
    
    @Published var newsHistory = [NewsViewModel]()
    @Published var blogHistory = [BlogViewModel]()
    
    func updateNews(newsList: [News]) {
        newsHistory.removeAll()
        for news in newsList{
            newsHistory.append(NewsViewModel(news: news))
        }
    }
    
    func updateBlog(blogList: [Blog]){
        blogHistory.removeAll()
        for blog in blogList{
            blogHistory.append(BlogViewModel(blog: blog))
        }
    }
}
