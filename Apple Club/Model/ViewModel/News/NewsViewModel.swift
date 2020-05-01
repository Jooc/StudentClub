//
//  NewsViewModel.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/8.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

struct NewsViewModel: Identifiable, Codable {
    var id:Int {news.id}
    
    var news: News
}
