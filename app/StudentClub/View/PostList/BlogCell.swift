//
//  BlogCell.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/3.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct BlogCell: View {
    @EnvironmentObject var store: Store
    var blogIndex: (Int, Int)
    
    var viewModel: BlogViewModel{
        self.store.appState.postListState.postListViewModel.dailyPostList[blogIndex.0].blogList[blogIndex.1]
    }
    
    var body: some View {
        VStack {
            HStack{
                KFImage(URL(string: viewModel.blog.blogPublisher.avatar))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(height: 50)
                    .padding(.leading, 10)
                
                VStack(spacing: 5) {
                    Text("Jooc")
                    Text("TITLE")
                        .font(.subheadline)
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15))
                    .padding()
                
            }
            .frame(height: 60)
            .padding(5)
            
            
            RichLickView(metaData: viewModel.metaData)
        }
        .frame(width: Globals.screen.width*0.9)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onAppear(){
            if self.viewModel.metaData.title == nil{
                self.store.dispatch(.loadBlogLPMetaData(blogIndex: self.blogIndex))
            }
        }
    }
}

struct BlogCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("Base").edgesIgnoringSafeArea(.all)
            BlogCell(blogIndex: (0, 0))
        }
    }
}
