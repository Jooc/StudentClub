import UIKit
import Foundation
import Combine

let requestBodyDic = ["email": "Jooc@qq.com", "password": "123456"]

var request = URLRequest(url: URL(string: "localhost:8080" + "/user/login")!)
request.httpMethod = "Post"
let postString = requestBodyDic.compactMap ({ (key,value) -> String? in
   return "\(key)=\(value)"
}).joined(separator: "&")

request.httpBody = postString.data(using: String.Encoding.utf8)

let publisher = URLSession.shared
    .dataTaskPublisher(for: request)
    .map{$0.data}
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()

private var disposeBag = Set<AnyCancellable>()

publisher.sink(receiveCompletion: { error in
    print(error)
}, receiveValue: { response in
    print(response)
    }).store(in: &disposeBag)
