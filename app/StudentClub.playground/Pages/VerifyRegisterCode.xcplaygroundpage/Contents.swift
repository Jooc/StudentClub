//: [Previous](@previous)

import Foundation
import Combine

enum AppError: Error{
    case network(Error)
    case invalidURL
}

let registerCode = "CY3E2O8WIL"


class SubscriptionToken {
    var cancellable: AnyCancellable?
    func unseal() { cancellable = nil }
}

extension AnyCancellable {
    func seal(in token: SubscriptionToken) {
        token.cancellable = self
    }
}

struct CResponse: Codable{
    var clubName:String
    var msg: String
    var code: Int
}

var publisher: AnyPublisher<String, AppError>{
    guard let url = URL(string: "http://localhost:8080/club/verifyRegisterCode?registerCode=" + registerCode) else{
        return Fail<String, AppError>(error: .invalidURL).eraseToAnyPublisher()
    }
    
    return URLSession.shared
        .dataTaskPublisher(for: url)
        .map{$0.data}
        .decode(type: CResponse.self, decoder: JSONDecoder())
        .map{String($0.clubName)}
        .mapError{AppError.network($0)}
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


