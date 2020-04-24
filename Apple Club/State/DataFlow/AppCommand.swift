//
//  AppCommand.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

protocol AppCommand {
    func excute(in store: Store)
}
