//
//  BlogCell.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/3.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct BlogCell: View {
    @EnvironmentObject var store: Store
    
    var viewModel: BlogViewModel
    
    var body: some View {
        VStack {
            HStack{
                KFImage(URL(string: Globals.OSSPrefix + viewModel.blog.publisherInfo.avatar))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(height: 50)
                    .padding(.leading, 10)
                
                VStack(spacing: 5) {
                    Text(viewModel.blog.publisherInfo.name)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15))
                    .padding()
                
            }
            .frame(height: 50)
            .padding(5)
            
            RichLinkView(metaData: viewModel.metaData)
        }
        .frame(width: Globals.screen.width*0.9)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onAppear(){
//            self.store.dispatch(.loadBlogLPMetaData(index: self.store.appState.postListState.postListViewModel.blogList.firstIndex(of: self.viewModel)!))
        }
    }
}

struct BlogCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("Base").edgesIgnoringSafeArea(.all)
            BlogCell(viewModel: BlogViewModel.Sample()).environmentObject(Store.Sample())
        }
    }
}
