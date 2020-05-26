//
//  LoadRequest.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/26.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

struct LoadNewsRequest {
    let userPrivilege: Int
    let batchNum: Int = 0
    
    var publisher: AnyPublisher<[News], AppError>{
        guard let url = URL(string: Globals.serverUrl +
            "/news/getByPrivilege?privilege=" + String(userPrivilege) + "&batchNum=" + String(batchNum)) else{
                return Fail<[News], AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [News].self, decoder: JSONDecoder())
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct LoadBlogRequest {
    let userPrivilege: Int
    let batchNum: Int = 0
    
    var publisher: AnyPublisher<[Blog], AppError>{
        guard let url = URL(string: Globals.serverUrl +
            "/blog/getByPrivilege?privilege=" + String(userPrivilege) + "&batchNum=" + String(batchNum))else{
                return Fail<[Blog], AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [Blog].self, decoder: JSONDecoder())
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct LoadEventRequest {
    let userId: Int
    
    var publisher: AnyPublisher<[Event], AppError>{
        print("UserID: \(userId)")
        guard let url = URL(string: Globals.serverUrl + "/event/getEventByUserId?userId=" + String(userId)) else {
            return Fail<[Event], AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: ResponseBody.self, decoder: JSONDecoder())
            .map{$0.events}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    struct ResponseBody:Decodable {
        var msg: String
        var code: Int
        var events: [Event]
    }
}

struct LoadNewsHistoryRequest {
    let userId: Int

    var publisher: AnyPublisher<[News], AppError>{
        guard let url = URL(string: Globals.serverUrl + "/news/getByUserId?user_id=" + String(userId)) else{
            return Fail<[News], AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [News].self, decoder: JSONDecoder())
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct LoadBlogHistoryRequest {
    let userId: Int
    
    var publisher: AnyPublisher<[Blog], AppError>{
        guard let url = URL(string: Globals.serverUrl + "/blog/getByUserId?id=" + String(userId))else{
            return Fail<[Blog], AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [Blog].self, decoder: JSONDecoder())
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

struct LoadClubListRequest {
    var publisher: AnyPublisher<[ClubInfo], AppError>{
        guard let url = URL(string: Globals.serverUrl + "/club/getAllClub")else{
            return Fail<[ClubInfo], AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: ResponseBody.self, decoder: JSONDecoder())
            .map{ClubInfo.transferClubs2ClubInfos(clubList: $0.clubs)}
//            .map{$0.clubs}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    struct ResponseBody: Decodable {
        var code: Int
        var msg: String
        var clubs: [Club]
    }
}

struct LoadMyClubMembersRequest {
    let clubCode: Int

    var publisher: AnyPublisher<(UserInfo, UserInfo, [UserInfo]), AppError>{
        guard let url = URL(string: Globals.serverUrl + "/club/getMembersByCode?clubCode=" + String(clubCode))else{
            return Fail<(UserInfo, UserInfo, [UserInfo]), AppError>(error: .invalidURL).eraseToAnyPublisher()
        }
        print(url)
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: ResponseBody.self, decoder: JSONDecoder())
            .map{($0.advisor, $0.manager, $0.members)}
            .mapError{AppError.networkFailed($0)}
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    struct ResponseBody: Decodable {
        var code: Int
        var msg: String
        var advisor: UserInfo
        var manager: UserInfo
        var members: [UserInfo]
    }
}
