//
//  NewsPage.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/4.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct NewsPage: View {
    @EnvironmentObject var store: Store
    var viewModel: NewsListViewModel{
        self.store.appState.newsState.newsListViewModel
    }
    
    var body: some View {
        ZStack {
            Color("Base")
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                ScrollView(showsIndicators: false) {
                    header
                    ForEach(viewModel.newsList){item in
                        NewsCell(viewModel: item)
                            .padding(.vertical, 20)
                    }
                }
                
//                List(viewModel.newsList) { item in
//                    NewsCell(viewModel: item)
//                        .padding(.vertical, 30)
//                }
            }
        }
    }

    var header: some View{
        HStack {
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 15) {
                    Text("4月27日 星期一")
                        .font(.system(size: 25))
                    Image(uiImage: #imageLiteral(resourceName: "News-Title"))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: screen.height*0.05)
                }
                .padding()
                .padding(.leading, 5)
                
                PostButton()
            }
            
        }.frame(width: screen.width, alignment: .topLeading)
    }
}

struct NewsPage_Previews: PreviewProvider {
    static var previews: some View {
        NewsPage().environmentObject(Store.Sample())
    }
}

