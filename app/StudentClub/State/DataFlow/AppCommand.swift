//
//  AppCommand.swift
//  StudentClub
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
        let token =  SubscriptionToken()
        LoginRequest(email: email, password: password)
        .publisher
        .sink(receiveCompletion: { complete in
            if case .failure(let error) = complete{
                store.dispatch(.accountBehaviorDone(result: .failure(error)))
            }
            token.unseal()
        }, receiveValue: { user in
            store.dispatch(.accountBehaviorDone(result: .success(user)))
            print(user)
            print(Globals.OSSPrefix + user.avatar)
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
                print(newsList)
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

struct LoadLPMetaDataAppCommand: AppCommand {
    let blogIndex: (Int,Int)

    func excute(in store: Store) {
        let blogViewModel = store.appState.postListState.postListViewModel.dailyPostList[blogIndex.0].blogList[blogIndex.1]
        let token = SubscriptionToken()
        guard let url = URL(string: blogViewModel.blog.url) else{
            print("Unavailable URL String @ Blog #\(blogViewModel.blog.id)")
            return
        }

        LoadLPMetaDataRequest(url: url)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadBlogLPMetaDataDone(blogIndex: self.blogIndex, result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { data in
                store.dispatch(.loadBlogLPMetaDataDone(blogIndex: self.blogIndex, result: .success(data)))
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
