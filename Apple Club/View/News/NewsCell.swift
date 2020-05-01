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
    @EnvironmentObject var store: Store
    var viewModel: NewsViewModel
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0){
            HStack{
                //                Image(uiImage: #imageLiteral(resourceName: "avatar-1"))
                KFImage(URL(string: viewModel.news.newsPublisher.avatar))
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
            KFImage(URL(string: viewModel.news.images[0]))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: screen.width*0.9, height: 330)
                .clipShape(Rectangle())
        }
        .background(Color.white)
        .frame(width: screen.width*0.9)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onTapGesture {
            self.store.dispatch(.clickNewsCell(news: self.viewModel))
        }
        
    }
    //        .shadow(radius: 30)
}


struct NewsCell_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("Base")
                .edgesIgnoringSafeArea(.all)
            NewsCell(viewModel: NewsViewModel.Sample(id: 1)).environmentObject(Store())
        }
    }
}
