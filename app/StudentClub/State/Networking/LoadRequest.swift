//
//  LoadRequest.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/26.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct LoadNewsRequest {
    let userPrivilege: Int

    var publisher: AnyPublisher<[News], AppError>{
        guard let url = URL(string: Globals.serverUrl + "/news/getByPrivilege?privilege=" + String(userPrivilege)) else{
            return Fail<[News], AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [News].self, decoder: JSONDecoder())
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct LoadBlogRequest {
    let userPrivilege: Int
    
    var publisher: AnyPublisher<[Blog], AppError>{
        guard let url = URL(string: Globals.serverUrl + "/blog/getByPrivilege?privilege=" + String(userPrivilege))else{
            return Fail<[Blog], AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [Blog].self, decoder: JSONDecoder())
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
