//
//  PostRequest.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/16.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

struct PostNewsRequest {
    var publsiher_id: Int
    var title: String
    var content: String
    var tags: String
    var privilege: Int
    var image: UIImage?

    var publsiher: AnyPublisher<News, AppError>{
            Future<News,AppError>{ promise in
                switch self.postNews(image: self.image){
                case .success(let response):
                    promise(.success(response.news))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func postNews(image: UIImage?) -> Result<PublishResponse, AppError> {
        let pars = ["publisher_id": String(self.publsiher_id), "title": self.title, "content": self.content, "tags": "[]", "privilege": String(self.privilege)]
        var result: PublishResponse?
        
        AF.upload(multipartFormData: { multipartFormData in
            if let imgData = image?.jpegData(compressionQuality: 0.1){
                multipartFormData.append(imgData, withName: "files", fileName: String(describing: "1" + ".jpg"), mimeType: "image/jpg")
            }
            for (key, value) in pars {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to: Globals.serverUrl + "/news/publish").responseDecodable(of: PublishResponse.self){response in
            
            result = response.value
        }
        if let unwrappedResult = result{
            return .success(unwrappedResult)
        }
        return .failure(AppError.uploadPostFailed)
    }
}

struct PublishResponse: Codable {
    var news: News
    var msg: String
    var code: Int
}

extension News{
    init(response: PublishResponse) {
        self = response.news
    }
}
