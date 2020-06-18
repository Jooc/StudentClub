//
//  LoginRequest.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/25.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct LoginRequest {
    let email: String
    let password: String
    
    var publisher: AnyPublisher<User, AppError>{
        let requestBody = LoginRequestBody(email: self.email, password: self.password)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let requestData = try! encoder.encode(requestBody)

        var request = URLRequest(url: URL(string: Globals.serverUrl + "/user/login")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData

        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map{ $0.data }
            .decode(type: LoginResponse.self, decoder: JSONDecoder())
            .map{User(loginResponse: $0)}
            .mapError{
                if $0.localizedDescription == "The data couldn’t be read because it is missing."{
                    return AppError.passwordWrong
                }
                else{
                    return AppError.networkFailed($0)
                }}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    struct LoginRequestBody: Encodable {
        var email: String
        var password: String
    }
}

struct LoginResponse: Decodable {
    var code: Int
    var msg: String
    var user: User
}

extension User{
    init(loginResponse: LoginResponse) {
        self = loginResponse.user
    }
}

//struct LoginRequest {
//    let email: String
//    let password: String
//
//    var publisher: AnyPublisher<User, AppError>{
//        Future{promise in
//            DispatchQueue.global()
//                .asyncAfter(deadline: .now()+1.5){
//                    if self.password == "123"{
//                        let user = User.Sample()
//                        promise(.success(user))
//                    }else{
//                        promise(.failure(.passwordWrong))
//                    }
//            }
//        }
//        .receive(on: DispatchQueue.main)
//        .eraseToAnyPublisher()
//    }
//}
