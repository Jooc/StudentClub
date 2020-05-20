//
//  PostViewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/3.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import LinkPresentation

class BlogViewModel:Hashable, Identifiable {
    func hash(into hasher: inout Hasher) { }
    static func == (lhs: BlogViewModel, rhs: BlogViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    var id: Int{
        self.blog.id
    }
    
    @Published var metaData = LPLinkMetadata()
    @Published var blog: Blog
    
    init(blog: Blog) {
        self.blog = blog
    }
}

class NewsViewModel: Hashable, Identifiable {
    func hash(into hasher: inout Hasher) { }
    static func == (lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        return lhs.id == rhs.id
    }
    var id:Int {
        self.news.id
    }
    
    @Published var news: News
    
    init(news: News) {
        self.news = news
    }
}
