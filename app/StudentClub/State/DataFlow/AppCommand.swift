//
//  AppCommand.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/5.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

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

struct RegisterAppCommand: AppCommand {
    let registerCode: String
    let loginEmail: String
    let userName: String
    let password: String
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        RegisterRequest(registerCode: registerCode, loginEmail: loginEmail, userName: userName, password: password).publisher
        .sink(receiveCompletion: {complete in
            if case .failure(let error) = complete{
                store.dispatch(.registerDone(result: .failure(error)))
            }
            token.unseal()
        }, receiveValue: { email in
            store.dispatch(.registerDone(result: .success(email)))
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
                debugPrint(newsList)
                store.dispatch(.loadNewsDone(result: .success(newsList)))
                store.dispatch(.loadBlog)
            }).seal(in: token)
    }
}

struct LoadBlogAppCommand: AppCommand {
    let userPrivilege: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        LoadBlogRequest(userPrivilege: userPrivilege)
        .publisher
        .sink(receiveCompletion: { complete in
            if case .failure(let error) = complete{
                store.dispatch(.loadBlogDone(result: .failure(error)))
            }
            token.unseal()
        }, receiveValue: { blogList in
            store.dispatch(.loadBlogDone(result: .success(blogList)))
            for index in store.appState.postListState.postListViewModel.blogList.indices{
                store.dispatch(.loadBlogLPMetaData(index: index))
            }
            store.dispatch(.loadEvents)
        }).seal(in: token)
    }
}

struct LoadClubListAppCommand: AppCommand {
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        LoadClubListRequest()
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadClubListDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { clubList in
                store.dispatch(.loadClubListDone(result: .success(clubList)))
                store.dispatch(.loadMyClubMembers)
            }).seal(in: token)
    }
}

struct LoadMyClubMembersAppCommand: AppCommand {
    let clubCode: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        LoadMyClubMembersRequest(clubCode: clubCode)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadMyClubMembersDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { membersList in
                store.dispatch(.loadMyClubMembersDone(result: .success(membersList)))
            }).seal(in: token)
    }
}

struct LoadUserAppCommand: AppCommand {
    let userID: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        LoadUserRequest(userID: userID)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadUserDetailDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { user in
                store.dispatch(.loadUserDetailDone(result: .success(user)))
            }).seal(in: token)
    }
}

struct LoadClubAppCommand: AppCommand {
    let clubCode: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        LoadClubRequest(clubCode: clubCode)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadClubListDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { club in
                store.dispatch(.loadClubDetailDone(result: .success(club)))
            }).seal(in: token)
    }
}


struct LoadEventsAppCommand: AppCommand {
    let userId: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        LoadEventRequest(userId: userId)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadEventsDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { events in
                store.dispatch(.loadEventsDone(result: .success(events)))
                store.dispatch(.loadClubList)
            }).seal(in: token)
    }
}

struct LoadNewsHistoryAppCommand: AppCommand {
    let userId: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        LoadNewsHistoryRequest(userId: userId)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadNewsHistoryDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { news in
                store.dispatch(.loadNewsHistoryDone(result: .success(news)))
            }).seal(in: token)
    }
}

struct LoadBlogHistoryAppCommand: AppCommand {
    let userId: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        LoadBlogHistoryRequest(userId: userId)
            .publisher
            .sink(receiveCompletion: {complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadBlogHistoryDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { blogs in
                store.dispatch(.loadBlogHistoryDone(result: .success(blogs)))
            }).seal(in: token)
    }
}

struct LoadLPMetaDataAppCommand: AppCommand {
    let blogIndex: Int

    func excute(in store: Store) {
        let blogViewModel = store.appState.postListState.postListViewModel.blogList[blogIndex]
        let token = SubscriptionToken()
        guard let url = URL(string: blogViewModel.blog.url) else{
            print("[ERROR]: Unavailable URL String @ Blog #\(blogViewModel.blog.id)")
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

struct LoadPostingLPMetaDataAppCommand: AppCommand {
    let url: String
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        guard let url = URL(string: self.url) else{
            print("[ERROR]: Unavailable URL String @ Blog Posting")
            return
        }
        
        LoadLPMetaDataRequest(url: url)
            .publisher
            .sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.loadPostingBlogLPMetaDataDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { data in
                store.dispatch(.loadPostingBlogLPMetaDataDone(result: .success(data)))
            }).seal(in: token)
    }
}

struct PostNewsAppCommand: AppCommand {
    var publsiher_id: Int
    var title: String
    var content: String
    var tags: String
    var privilege: Int
    var image: UIImage?
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        PostNewsRequest(publsiher_id: publsiher_id, title: title, content: content, tags: tags, privilege: privilege, image: image)
            .publsiher.sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.postNewsDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { news in
                store.dispatch(.postNewsDone(result: .success(news)))
            }).seal(in: token)
    }
}

struct PostBlogAppCommand: AppCommand {
    var userId: Int
    var blogUrl: String
    var privilege: Int
    var tags: String
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        PostBlogRequest(userId: userId, blogUrl: blogUrl, privilege: privilege, tags: tags)
            .publisher
        .sink(receiveCompletion: { complete in
            if case .failure(let error) = complete{
                store.dispatch(.postBlogDone(result: .failure(error)))
            }
            token.unseal()
        }, receiveValue: { blog in
            store.dispatch(.postBlogDone(result: .success(blog)))
        }).seal(in: token)
    }
}

struct DeleteClubMemberAppCommand: AppCommand {
    let requestBody: DeleteClubMemberRequest.RequestBody
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        DeleteClubMemberRequest(requestBody: requestBody)
        .publisher
        .sink(receiveCompletion: { complete in
            if case .failure(let error) = complete{
                store.dispatch(.deleteClubMemberDone(result: .failure(error)))
            }
            token.unseal()
        }, receiveValue: {memberList in
            store.dispatch(.deleteClubMemberDone(result: .success(memberList)))
        }).seal(in: token)
    }
}

struct PublishEventAppCommand: AppCommand {
    var requestBody: PublishEventRequest.RequestBody
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        PublishEventRequest(requestBody: requestBody)
        .publisher
        .sink(receiveCompletion: { complete in
            if case .failure(let error) = complete{
                store.dispatch(.publishEventDone(result: .failure(error)))
            }
            token.unseal()
        }, receiveValue: { event in
            store.dispatch(.publishEventDone(result: .success(event)))
        }).seal(in: token)
    }
}

struct VerifyRegisterCodeAppCommand: AppCommand {
    var registerCode: String
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        VerifyRegisterCodeRequest(registerCode: registerCode)
            .publisher.sink(receiveCompletion: {complete in
                if case .failure(let error) = complete{
                    store.dispatch(.verifyRegisterCodeDone(result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { clubName in
                store.dispatch(.verifyRegisterCodeDone(result: .success(clubName)))
            }).seal(in: token)
    }
}

struct EditProfileInfoAppCommand: AppCommand {
    var target: EditProfileInfoRequest.EditTarget
    var userId: Int
    var param: String
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        EditProfileInfoRequest(target: target, id: userId, param: param)
            .publisher.sink(receiveCompletion: { complete in
                if case .failure(let error) = complete{
                    store.dispatch(.editProfileInfoDone(target: self.target, result: .failure(error)))
                }
                token.unseal()
            }, receiveValue: { user in
                store.dispatch(.editProfileInfoDone(target: self.target, result: .success(user)))
            }).seal(in: token)
    }
}

struct PQEventAppCommand: AppCommand {
    var action: PQEventRequest.Action
    var eventId: Int
    var userId: Int
    
    func excute(in store: Store) {
        let token = SubscriptionToken()
        
        PQEventRequest(action: action, requestBody: PQEventRequest.RequestBody(eventId: eventId, userId: userId))
            .publisher
        .sink(receiveCompletion: { complete in
            if case .failure(let error) = complete{
                store.dispatch(.pqEventDone(action: self.action, result: .failure(error)))
            }
            token.unseal()
        }, receiveValue: { event in
            store.dispatch(.pqEventDone(action: self.action, result: .success(event)))
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




