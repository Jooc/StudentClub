//
//  DeleteRequest.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/23.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct DeleteClubMemberRequest {
    let requestBody: RequestBody
    
    var publisher: AnyPublisher<(UserInfo, UserInfo, [UserInfo]), AppError>{
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let requestData = try! encoder.encode(requestBody)

        var request = URLRequest(url: URL(string: Globals.serverUrl + "/club/removeMember")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .map{$0.data}
            .decode(type: ResponseBody.self, decoder: JSONDecoder())
            .map{($0.advisor, $0.manager, $0.members)}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    struct RequestBody: Encodable {
        var clubCode: Int
        var targetMemberId: Int
    }
    
    struct ResponseBody: Decodable {
        var code: Int
        var msg: String
        var advisor: UserInfo
        var manager: UserInfo
        var members: [UserInfo]
    }
}
