//: [Previous](@previous)

import Foundation
import Combine

struct UserInfo: Codable {
    var id: Int
    var name: String
    var avatar: String
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

class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}

enum AppError: Error{
    case invalidURL, networkFailed(Error)
}

var publisher: AnyPublisher<[News], AppError>{
    guard let url = URL(string: "http://localhost:8080/news/getByPrivilege?privilege=2") else{
        return Fail<[News], AppError>(error: .invalidURL).eraseToAnyPublisher()
    }

    return URLSession.shared
        .dataTaskPublisher(for: url)
        .map{$0.data}
        .decode(type: [News].self, decoder: JSONDecoder())
        .mapError{AppError.networkFailed($0)}
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
}

let token = SubscriptionToken()
publisher.sink(receiveCompletion: { complete in
    print(complete)
    token.unseal()
}, receiveValue: { response in
    print(response)
}).seal(in: token)
