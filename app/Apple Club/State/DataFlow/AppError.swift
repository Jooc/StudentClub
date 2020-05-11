//
//  AppError.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

enum AppError: Int, Error, Identifiable{
    var id: Int{
        self.rawValue
    }

    // LoginError
    case passwordWrong = 0101
    
    // LoadError
    case loadNewsError = 0201
    case loadEventError = 0202
    case loadLinkPresentation = 0203
}

extension AppError: LocalizedError{
    var localizedDescription: String{
        switch self {
        case .passwordWrong: return "密码错误"
        case .loadNewsError: return "加载新闻失败"
        case .loadEventError: return "加载时间失败"
        case .loadLinkPresentation: return "加载Blog失败"
        }
    }
    
    var errorCode: Int{
        return id
    }
}

