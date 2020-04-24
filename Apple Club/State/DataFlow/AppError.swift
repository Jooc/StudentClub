//
//  AppError.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

enum AppError: Error, Identifiable{
    var id: String {localizedDescription}
    
}

extension AppError: LocalizedError{
    var localizedDescription: String{
        switch self {
            
        }
    }
}
