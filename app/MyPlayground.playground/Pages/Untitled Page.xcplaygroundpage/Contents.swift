import UIKit
import Foundation
import Combine
struct LoginResponse: Codable{
    var msg: String
    var code: Int
    var user: User
    
    struct User: Codable {
        var id: Int
        var userName: String?
        var avatar: String
        //TODO: var gender: Gender
        var gender: String
        var description: String?
        var clubInfo: ClubInfo
        var userPrivilege: Int
        
        var loginEmail: String
        var password: String
        
        var contactEmail: String
        var phoneNumber: String
        
        struct ClubInfo: Codable {
            var clubCode: Int
            var clubName: String
            var clubAvatar: String?
        }
    }
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

struct LoginRequest: Codable{
    var email: String
    var password: String
}

let pear = LoginRequest(email: "Jooc@qq.com", password: "123456")
let encode = JSONEncoder()
encode.outputFormatting = .prettyPrinted

let data = try encode.encode(pear)
print(String(data: data, encoding: .utf8)!)
let url = "http://localhost:8080/user/login"

var request = URLRequest(url: URL(string: url)!)
request.httpMethod = "POST"
request.setValue("application/json", forHTTPHeaderField: "Content-Type")
request.httpBody = data

var publisher:AnyPublisher<LoginResponse, Error> = URLSession.shared
    .dataTaskPublisher(for: request)
    .map{data, _ in data}
    .decode(type: LoginResponse.self, decoder: JSONDecoder())
//    .compactMap{$0.userName}
    .receive(on: DispatchQueue.main)
    .eraseToAnyPublisher()

let token = SubscriptionToken()
publisher.sink(receiveCompletion: { complete in
    print(complete)
    token.unseal()
}, receiveValue: { response in
    print(response)
}).seal(in: token)

