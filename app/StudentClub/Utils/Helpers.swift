//
//  Helpers.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/8.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation

let appDecoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

let appEncoder: JSONEncoder = {
    let encoder = JSONEncoder()
    encoder.keyEncodingStrategy = .convertToSnakeCase
    return encoder
}()
