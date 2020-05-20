//
//  EditUserInfoRequest.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct EditProfileInfoRequest {
    enum EditTarget {
        case name, gender, phoneNumber, contactEmail
    }
    
    let target: EditTarget
    let id: Int
    let param: String
    
    var publisher: AnyPublisher<User, AppError>{
        
        var urlSuffix = ""
        var requestData: Data?
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        switch self.target {
        case .name:
            urlSuffix = "/user/editUserName"
            requestData = try! encoder.encode(NameRequestBody(id: id, newName: param))
        case .gender:
            urlSuffix = "/user/editGender"
            requestData = try! encoder.encode(GenderRequestBody(id: id, newGender: param))
        case .phoneNumber:
            urlSuffix = "/user/editPhoneNumber"
            requestData = try! encoder.encode(PhoneNumberRequestBody(id: id, newPhoneNumber: param))
        case .contactEmail:
            urlSuffix = "/user/editContactEmail"
            requestData = try! encoder.encode(ContactEmailRequestBody(id: id, newContactEmail: param))
        }
        
        guard let url = URL(string: Globals.serverUrl + urlSuffix)else{
              return Fail<User, AppError>(error: .invalidURL).eraseToAnyPublisher()
          }
          print(url)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: ResponseBody.self, decoder: JSONDecoder())
            .map{$0.user}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    struct NameRequestBody:Encodable {
        var id: Int
        var newName: String
    }
    struct GenderRequestBody:Encodable {
        var id: Int
        var newGender: String
    }
    struct PhoneNumberRequestBody:Encodable {
        var id: Int
        var newPhoneNumber: String
    }
    struct ContactEmailRequestBody:Encodable {
        var id: Int
        var newContactEmail: String
    }
    
    struct ResponseBody: Decodable {
        var code: Int
        var msg: String
        var user: User
    }
}
