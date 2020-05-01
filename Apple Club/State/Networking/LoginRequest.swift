//
//  LoginRequest.swift
//  Apple Club
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
        Future{promise in
            DispatchQueue.global()
                .asyncAfter(deadline: .now()+1.5){
                    if self.password == "123"{
                        let user = User.Sample()
                        promise(.success(user))
                    }else{
                        promise(.failure(.passwordWrong))
                    }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
