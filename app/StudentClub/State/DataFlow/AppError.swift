//
//  AppError.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

enum AppError: Error, Identifiable{
    var id: String{
        localizedDescription
    }

    // LoginError
    case passwordWrong
    
    // LoadError
    case loadNewsError
    case loadEventError
    case loadLinkPresentation
    
    case networkFailed(Error)
    case invalidURL
}

extension AppError: LocalizedError{
    var localizedDescription: String{
        switch self {
        case .passwordWrong: return "密码错误"
        case .loadNewsError: return "加载新闻失败"
        case .loadEventError: return "加载时间失败"
        case .loadLinkPresentation: return "加载Blog失败"
        case .networkFailed(let error): return "网络连接错误: " + error.localizedDescription
        case .invalidURL: return "URL 失效"
        }
    }
    
//    var errorCode: Int{
//        switch <#value#> {
//        case <#pattern#>:
//            <#code#>
//        default:
//            <#code#>
//        }
//    }
}

