//
//  PostListViewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/25.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct PostListViewModel{
    var date: String
    
    var blogList = [BlogViewModel]()
    var newsList = [NewsViewModel]()
    
    mutating func updateNews(newsList: [News]){
        self.newsList.removeAll()
        for news in newsList{
            self.newsList.append(NewsViewModel(news: news))
        }
    }
    mutating func updateBlog(blogList: [Blog]){
        self.blogList.removeAll()
        for blog in blogList{
            self.blogList.append(BlogViewModel(blog: blog))
        }
    }
}
