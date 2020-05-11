//
//  RichLinkView.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/5/3.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import LinkPresentation

struct RichLickView: UIViewRepresentable {
    var metaData: LPLinkMetadata
    
    func makeUIView(context: UIViewRepresentableContext<RichLickView>) -> LPLinkView {
        return LPLinkView(metadata: self.metaData)
    }
    
    func updateUIView(_ uiView: LPLinkView, context: UIViewRepresentableContext<RichLickView>) {
        uiView.metadata = self.metaData
    }
}
