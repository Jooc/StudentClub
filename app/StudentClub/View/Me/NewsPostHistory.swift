//
//  NewsPost.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/9.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct NewsPostHistory: View {
    @EnvironmentObject var store: Store
    
    var viewModel: PostHistoryViewModel{
        self.store.appState.postHistoryState.viewModel
    }
    
    var body: some View {
        VStack {
            HStack{
                Button(action: {
                    self.store.appState.rightSliderPageState = .NONE
                }){
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("返回")
                    }
                    .foregroundColor(Color.black)
                    .padding(.all, 5)
                }
                Spacer()
            }
            .padding(.horizontal)
            
            NavigationView {
                List{
                    ForEach(self.viewModel.newsHistory, id: \.self){ news in
                        NavigationLink(destination: Text(news.news.title)){
                            NewsPostCell(viewMode: news)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
        .navigationBarTitle("NewsHistory")
        .navigationBarHidden(true)
        }.onAppear(){
            self.store.dispatch(.loadNewsHistory)
        }
    }
}

struct NewsPostHistory_Previews: PreviewProvider {
    static var previews: some View {
        NewsPostHistory().environmentObject(Store.Sample())
    }
}
