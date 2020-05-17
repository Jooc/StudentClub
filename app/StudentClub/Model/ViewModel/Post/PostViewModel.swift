//
//  PostViewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/3.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import LinkPresentation

struct BlogViewModel:Hashable, Identifiable {
    static func == (lhs: BlogViewModel, rhs: BlogViewModel) -> Bool {
        return lhs.nID == rhs.nID
    }
    
    var nID = UUID()
    
    var id:Int {blog.id}
    
    var metaData = LPLinkMetadata()
    var blog: Blog
}

struct NewsViewModel: Hashable, Identifiable, Codable {
    static func == (lhs: NewsViewModel, rhs: NewsViewModel) -> Bool {
        return lhs.nID == rhs.nID
    }
    var nID = UUID()
    
    var id:Int {news.id}
    
    var news: News
}
