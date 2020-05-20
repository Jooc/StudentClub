//
//  PublishEventRequest.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/18.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct PublishEventRequest {
    var requestBody: RequestBody
    
    var publisher: AnyPublisher<Event, AppError>{
        guard let url = URL(string: Globals.serverUrl + "/event/publish")else{
            return Fail<Event, AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        
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
            .map{Event(response: $0)}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    
    struct RequestBody: Encodable{
        var title: String
        var location: String
        var startDate: String
        var endDate: String
        var url: String
        var notes: String
        var initiatorId: Int
        var participant: String
        var openOrNot: Int
        
        init(event: Event, userId: Int) {
            self.title = event.title
            self.location = event.location
            self.startDate = event.startDate
            self.endDate = event.endDate
            self.url = event.url
            self.notes = event.notes
            self.initiatorId = userId
            self.participant = event.participant
            self.openOrNot = event.openOrNot
        }
    }
    
    struct ResponseBody: Decodable {
        var msg: String
        var code: Int
        var event: Event
    }
}

extension Event{
    init(response: PublishEventRequest.ResponseBody) {
        self = response.event
    }
}
