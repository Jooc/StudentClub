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
    
    var body: some View {
        ZStack {
            Color("Base")
                .edgesIgnoringSafeArea(.all)
            List(NewsViewModel.all) { item in
                NewsCell(news: item)
                    .padding(.vertical, 30)
            }
        }
    }
}

struct NewsPage_Previews: PreviewProvider {
    static var previews: some View {
        NewsPage().environmentObject(Store.Sample())
    }
}


//NavigationView {
//    List(NewsViewModel.all){ news in
//        NavigationLink(destination:
//        Text(news.news.content)
//            .onTapGesture {
//                self.store.dispatch(.showLogin)
//            }
//        ) {
//            NewsCell(news: news)
//                .padding(.vertical)
//        }
//    }
//    .navigationBarTitle(Text("News"))
//}
