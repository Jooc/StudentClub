//
//  PostListViewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/25.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

class PostListViewModel{
    var date: String
    
    @Published var blogList = [BlogViewModel]()
    @Published var newsList = [NewsViewModel]()
    
    init(date: String) {
        self.date = date
    }
    
    func updateNews(newsList: [News]){
        self.newsList.removeAll()
        for news in newsList{
            self.newsList.append(NewsViewModel(news: news))
        }
    }
    func updateBlog(blogList: [Blog]){
        self.blogList.removeAll()
        for blog in blogList{
            self.blogList.append(BlogViewModel(blog: blog))
        }
    }
}
