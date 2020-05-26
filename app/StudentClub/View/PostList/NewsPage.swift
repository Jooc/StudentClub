//
//  NewsPage.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct NewsPage: View {
    @ObservedObject var store: Store
    @GestureState private var translation = CGPoint.zero
    
    var viewModel: PostListViewModel{
        self.store.appState.postListState.postListViewModel
    }
    
    var body: some View {
        ZStack {
            Color("Base")
                .edgesIgnoringSafeArea(.all)
            VStack {
                RefreshableScrollView(refreshing: self.$store.refreshableScrollViewIsLoading){
                    header
                    VStack{
                        ForEach(viewModel.newsList, id: \.self){viewModel in
                            NewsCell(viewModel: viewModel)
                                .padding(.vertical)
                        }
                        ForEach(viewModel.blogList, id: \.self){viewModel in
                            BlogCell(viewModel: viewModel)
                                .padding(.vertical)
                        }
                    }
                }.background(Color(UIColor.secondarySystemBackground))
            }
            
        }
    }
    
    var header: some View{
        HStack {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 15) {
                    Text(viewModel.date)
                        .font(.system(size: 25))
                    Image(uiImage: #imageLiteral(resourceName: "News-Title"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: Globals.screen.height*0.05)
                }
                .padding()
                .padding(.leading, 5)
                
                PostButton()
                    .padding(.top, 10)
            }
            
        }.frame(width: Globals.screen.width, alignment: .topLeading)
    }
}

struct NewsPage_Previews: PreviewProvider {
    static var previews: some View {
        NewsPage(store: Store.Sample())
    }
}

