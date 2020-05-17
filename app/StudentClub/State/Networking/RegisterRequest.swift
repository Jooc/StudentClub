//
//  RegisterRequest.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/17.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct RegisterRequest{
    var registerCode: String
    var loginEmail: String
    var userName: String
    var password: String
    
    var publisher: AnyPublisher<String, AppError>{
        guard let url = URL(string: Globals.serverUrl + "/user/register")else{
            return Fail<String, AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        
        let requestBody = RequestBody(registerCode: registerCode, login_email: loginEmail, name: userName, password: password)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let requestData = try! encoder.encode(requestBody)

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: ResponseBody.self, decoder: JSONDecoder())
            .map{$0.user.loginEmail}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    struct ResponseBody:Decodable {
        var msg: String
        var code: Int
        var user: User
    }
    
    struct RequestBody: Encodable {
        var registerCode: String
        var login_email: String
        var name: String
        var password: String
    }
}
