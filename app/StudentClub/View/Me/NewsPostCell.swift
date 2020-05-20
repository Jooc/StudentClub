//
//  NewsPostCell.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/19.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct NewsPostCell: View {
    var viewMode: NewsViewModel
    
    var body: some View {
        HStack {
            KFImage(URL(string: Globals.OSSPrefix + viewMode.news.images[0]))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(20)
                .padding(.trailing, 4)
            VStack(alignment: .leading, spacing: 8){
                Text(viewMode.news.title)
                    .font(.system(size: 20, weight: .bold))
                Text(viewMode.news.content)
                    .lineLimit(2)
                    .font(.system(.subheadline))
                    .foregroundColor(Color.gray)
                Text(viewMode.news.cutPostTime())
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
            }
        }
    }
}

struct NewsPostCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsPostCell(viewMode: NewsViewModel.Sample(id: 1))
    }
}
