//
//  Participate&QuitEvent.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/20.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct PQEventRequest {
    enum Action{
        case Participate, Quit
    }
    
    let action: Action
    let requestBody: RequestBody
    
    var publisher: AnyPublisher<Event, AppError>{
        var urlSuffix = ""
        
        switch self.action {
        case .Participate:
            urlSuffix = "/event/participateEvent"
        case .Quit:
            urlSuffix = "/event/quitEvent"
        }
        guard let url = URL(string: Globals.serverUrl + urlSuffix)else{
            return Fail<Event, AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        
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
            .map{$0.event}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    struct RequestBody: Encodable {
        var eventId: Int
        var userId: Int
    }
    
    struct ResponseBody: Decodable {
        var code: Int
        var msg: String
        var event: Event
    }
}
