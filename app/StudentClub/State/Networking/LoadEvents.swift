//
//  LoadEvents.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/26.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct LoadEventssRequest {
    let userID: Int
    
    var publisher: AnyPublisher<[Event], AppError>{
        Future{promise in
            DispatchQueue.global()
                .asyncAfter(deadline: .now() + 1.5){
                    if true{
                        let events = Event.all
                        promise(.success(events))
                    }else{
                        promise(.failure(.loadNewsError))
                    }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}
