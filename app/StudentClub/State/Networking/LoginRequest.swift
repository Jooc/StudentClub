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
    let url = Globals.host + ":" + Globals.port
    
    let email: String
    let password: String

    var publisher: AnyPublisher<User, AppError>{
        let requestBodyDic = ["emai": email, "password": password]
        
        var request = URLRequest(url: URL(string: url + "/user/login")!)
        request.httpMethod = "Post"
        
        let postString = requestBodyDic.compactMap ({ (key,value) -> String? in
           return "\(key)=\(value)"
        }).joined(separator: "&")
        
        request.httpBody = postString.data(using: String.Encoding.utf8)

        
        
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map{$0.data}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
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
