//
//  VerifyRegisterCode.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/17.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct VerifyRegisterCodeRequest {
    let registerCode: String
    
    var publisher: AnyPublisher<String, AppError>{
        guard let url = URL(string: Globals.serverUrl + "/club/verifyRegisterCode?registerCode=" + registerCode) else{
            return Fail<String, AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        
        return URLSession.shared
        .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: Response.self, decoder: JSONDecoder())
            .map{String($0.clubName)}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    struct Response: Decodable {
        var clubName: String
        var msg: String
        var code: Int
    }
}

