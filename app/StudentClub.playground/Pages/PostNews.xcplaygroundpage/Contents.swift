//: [Previous](@previous)

import Foundation
import SwiftUI
import Combine

struct UserInfo: Codable {
    var id: Int
    var name: String
    var avatar: String
}

enum AppError: Error{
    case networkFailed(Error)
    case invalidURL
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

struct News: Codable {
    var id: Int
    var postTime: String
    
    var title: String
    var content: String
    var images: [String]
    
    var publisherInfo: UserInfo
    var privilege: Int
    
    var tags: String
}


func createBody(parameters: [String: Any],
                boundary: String,
//                data: Data,
                mimeType: String,
                filename: String) -> Data {
    let body = NSMutableData()
    
    let boundaryPrefix = "--\(boundary)\r\n"
    
    for (key, value) in parameters {
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
        body.appendString("\(value)\r\n")
    }
    
    body.appendString(boundaryPrefix)
    body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
    body.appendString("Content-Type: \(mimeType)\r\n\r\n")
//    body.append(data)
    body.appendString("\r\n")
    body.appendString("--".appending(boundary.appending("--")))
    
    return body as Data
}

extension NSMutableData{
    func appendString(_ string: String) {
           let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
           append(data!)
       }
}

var image = UIImage()

var request  = URLRequest(url: URL(string: "https://localhost:8080/news/publish")!)
request.httpMethod = "POST"
let boundary = "Boundary-\(UUID().uuidString)"
request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
request.httpBody = createBody(parameters: ["publisher_id": 1, "title": "111", "content": "222", "tags": "[11,11]", "privilege": 0],
                        boundary: boundary,
//                        data: image.jpegData(compressionQuality:0.7)!,
                        mimeType: "image/JPG",
                        filename: "hello.JPG")

var publisher = URLSession.shared
    .dataTaskPublisher(for: request)
    .map{$0.data}
    .decode(type: PublishResponse.self, decoder: JSONDecoder())
    .map{News(response: $0)}
    .mapError{AppError.networkFailed($0)}
    .eraseToAnyPublisher()

class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}

let token = SubscriptionToken()
publisher.sink(receiveCompletion: { complete in
    print(complete)
    token.unseal()
}, receiveValue: { response in
    print(response)
}).seal(in: token)


