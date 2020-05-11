//
//  LoadLPMetaDataRequest.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/5/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import Foundation
import Combine
import LinkPresentation

struct LoadLPMetaDataRequest {
    let url: URL
    let provider = LPMetadataProvider()

    var publisher: AnyPublisher<LPLinkMetadata, AppError>{
        Future{ promise in
            self.provider.startFetchingMetadata(for: self.url) {metaData, error in
                if error != nil{
                    promise(.failure(AppError.loadLinkPresentation))
                }
                if let unwrapperMetadata = metaData{
                    promise(.success(unwrapperMetadata))
                }
            }
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
}

