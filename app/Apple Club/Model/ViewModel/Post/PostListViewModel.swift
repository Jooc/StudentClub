//
//  PostListViewModel.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/25.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct DailyPostViewModel {
    var date: String
    
//    mix blog and news
//    var postList = [PostViewModel]()
    
    var blogList: [BlogViewModel]
    var newsList: [NewsViewModel]
}

struct PostListViewModel{
    var dailyPostList = [DailyPostViewModel]()
}

extension DailyPostViewModel{
        mutating func updateNews(newsList: [News]){
            self.newsList.removeAll()
            for news in newsList{
                self.newsList.append(NewsViewModel(news: news))
            }
        }
    
        mutating func updateBlogs(blogList: [Blog]){
            self.blogList.removeAll()
            for blog in blogList{
                self.blogList.append(BlogViewModel(blog: blog))
            }
        }
}

//extension NewsListViewModel{
//    mutating func updateNews(newsList: [News]){
//        self.newsList.removeAll()
//        for news in newsList{
//            self.newsList.append(NewsViewModel(news: news))
//        }
//    }
//
//    mutating func updateBlogs(blogList: [Blog]){
//        self.blogList.removeAll()
//        for blog in blogList{
//            self.blogList.append(BlogViewModel(blog: blog))
//        }
//    }
//
//    mutating func updateList(){
//        cellList.removeAll()
//
//        var index1 = 0
//        var index2 = 0
//
//        while index1 < newsList.count && index2 < blogList.count{
//            if newsList[index1].news.postTime > blogList[index2].blog.postTime{
//                cellList.append(1)
//                index1 += 1
//            }else{
//                cellList.append(2)
//                index2 += 1
//            }
//        }
//        while index1 < newsList.count{
//            cellList.append(1)
//            index1 += 1
//        }
//
//        while index2 < blogList.count{
//            cellList.append(2)
//            index2 += 1
//        }
//    }
//}
