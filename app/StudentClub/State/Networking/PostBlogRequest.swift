//
//  PostBlogRequest.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/17.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct PostBlogRequest{
    var userId: Int
    var blogUrl: String
    var privilege: Int
    var tags: String
    
    var publisher: AnyPublisher<Blog, AppError>{
        guard let url = URL(string: Globals.serverUrl + "/blog/publish")else{
            return Fail<Blog, AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        
        let requestBody = RequestBody(publisher_id: userId, url: blogUrl, privilege: privilege, tags: tags)
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
            .map{Blog(response: $0)}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    struct ResponseBody:Decodable {
        var msg: String
        var code: Int
        var blog: Blog
    }
    
    struct RequestBody: Encodable {
        var publisher_id: Int
        var url: String
        var privilege: Int
        var tags: String
    }
}

extension Blog{
    init(response: PostBlogRequest.ResponseBody) {
        self = response.blog
    }
}
