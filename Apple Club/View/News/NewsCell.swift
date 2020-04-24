//
//  NewsCell.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/4/8.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct NewsCell: View {
    var news: NewsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack{
//                Image(uiImage: #imageLiteral(resourceName: "avatar-1"))
                KFImage(URL(string: news.news.user.avatar))
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
            
//            Image(uiImage: #imageLiteral(resourceName: "news-1"))
            KFImage(URL(string: news.news.images![0]))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: screen.width*0.9, height: 330)
                .clipShape(Rectangle())
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .frame(width: screen.width*0.9, height: 400)
        .shadow(radius: 30)
    }
}


struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsCell(news: NewsViewModel.Sample(id: 1))
    }
}


//VStack {
//    HStack {
//        VStack {
//            KFImage(URL(string: news.news.user.avatar))
//                .resizable()
//                .cornerRadius(20)
//                .aspectRatio(contentMode: .fit)
//                .frame(maxHeight: 70)
//        }
//        VStack(alignment: .leading) {
//            Text(news.news.user.username)
//                .font(Font.headline)
//                .foregroundColor(.blue)
//            Text(news.news.title)
//                .font(Font.subheadline)
//            Text(news.news.content)
//                .font(.subheadline)
//                .lineLimit(1)
//        }
//        .padding(.leading, 5)
//    }
//    .frame(maxWidth: screen.width, maxHeight: 300, alignment: .leading)
//}
