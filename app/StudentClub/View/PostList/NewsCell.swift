//
//  NewsCell.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/8.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct NewsCell: View {
    @EnvironmentObject var store: Store
    var viewModel: NewsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing: 10){
                KFImage(URL(string: Globals.OSSPrefix + viewModel.news.publisherInfo.avatar))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
                    .frame(height: 50)
                    .padding(.leading, 10)
                    .onTapGesture {
                        self.store.appState.detailsState.detailedUserID = self.viewModel.news.publisherInfo.id
                }
                
                VStack(alignment:.leading, spacing: 5) {
                    Text(viewModel.news.publisherInfo.name)
                    Text(viewModel.news.title)
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
            KFImage(URL(string: Globals.OSSPrefix + viewModel.news.images[0]))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: Globals.screen.width*0.9)
                .frame(maxHeight: 350)
                .clipShape(Rectangle())
        }
        .background(Color.white)
        .frame(width: Globals.screen.width*0.9)
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
