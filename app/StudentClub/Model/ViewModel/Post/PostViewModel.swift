//
//  PostViewModel.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/3.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import LinkPresentation

struct BlogViewModel: Identifiable {
    var id:Int {blog.id}
    
    var metaData = LPLinkMetadata()
    var blog: Blog
}

struct NewsViewModel: Identifiable, Codable {
    var id:Int {news.id}
    
    var news: News
}
