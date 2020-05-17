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

extension String{
    var isValidEmailAddress: Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}

func createBody(parameters: [String: Any],
                boundary: String,
                data: Data,
                mimeType: String,
                filename: String) -> Data {
    let body = NSMutableData()
    
    let boundaryPrefix = "--\(boundary)\r\n"
    
    for (key, value) in parameters {
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
        body.appendString("\(value)\r\n")
    }
    
    body.appendString(boundaryPrefix)
    body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimeType)\r\n\r\n")
    body.append(data)
    body.appendString("\r\n")
    body.appendString("--".appending(boundary.appending("--")))
    
    return body as Data
}

extension NSMutableData{
    func appendString(_ string: String) {
           let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
           append(data!)
       }
}
