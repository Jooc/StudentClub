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


//struct LoadNewsRequest {
//    let userPrivilege: Int
//
//    var publisher: AnyPublisher<[News], AppError>{
//        Future{promise in
//            DispatchQueue.global()
//                .asyncAfter(deadline: .now() + 1.5){
//                    if true{
//                        let newsList = News.all
//                        promise(.success(newsList))
//                    }else{
//                        promise(.failure(.loadNewsError))
//                    }
//            }
//        }
//        .receive(on: DispatchQueue.main)
//        .eraseToAnyPublisher()
//    }
//}
