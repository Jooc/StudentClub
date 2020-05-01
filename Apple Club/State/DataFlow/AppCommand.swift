//
//  AppCommand.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine

protocol AppCommand {
    func excute(in store: Store)
}

struct LoginAppCommand: AppCommand {
    let email: String
    let password: String
    
    func excute(in store: Store) {
        store.dispatch(.inputDone)
        let token = SubscriptionToken()
        LoginRequest(email: email, password: password)
        .publisher
        .sink(receiveCompletion: { complete in
            if case .failure(let error) = complete{
                store.dispatch(.accountBehaviorDone(result: .failure(error)))
            }
            token.unseal()
        }, receiveValue: { user in
            store.dispatch(.accountBehaviorDone(result: .success(user)))
//            store.dispatch(.loadNews)
        }).seal(in: token)
    }
}

struct LoadNewsAppCommand: AppCommand {
    let userPrivilege: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        LoadNewsRequest(userPrivilege: userPrivilege)
            .publisher
            .sink(receiveCompletion:{ complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadNewsDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue:{ newsList in
                store.dispatch(.loadNewsDone(result: .success(newsList)))
            }).seal(in: token)
    }
}

struct LoadEventsAppCommand: AppCommand {
    let userID: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        LoadEventssRequest(userID: userID)
        .publisher
        .sink(receiveCompletion: { complete in
            if case .failure(let error) = complete{
                store.dispatch(.loadEventsDone(result: .failure(error)))
            }
            token.unseal()
        }, receiveValue: { events in
            store.dispatch(.loadEventsDone(result: .success(events)))
        }).seal(in: token)
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
