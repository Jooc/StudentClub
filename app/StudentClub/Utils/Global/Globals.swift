//
//  GlobalParameters.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import SwiftUI

class Globals {
    static let screen = UIScreen.main.bounds

    private let host = "http://localhost"
    private let port = "8080"
    static let serverUrl = "http://localhost:8080"
    
    static let OSSPrefix = "https://jooc-studentclub.oss-cn-huhehaote.aliyuncs.com"
    static let defaultAvatarURL = URL(string: Globals.OSSPrefix + "/UserAvatar/defaultAvatat.png")!
}

