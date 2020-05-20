//
//  NewsDetail.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/4/29.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct NewsDetail: View {
    @EnvironmentObject var store: Store
    var viewModel: NewsViewModel
    
    @Binding var show: Bool
    
    var body: some View {
        ZStack(alignment: .top) {
            Color("Base")
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical) {
                ZStack {
                    VStack(alignment: .leading, spacing: 30) {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack {
                                ForEach(viewModel.news.images, id:\.self) { image in
                                    VStack {
                                        KFImage(URL(string: Globals.OSSPrefix + image))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    }.frame(width: Globals.screen.width)
                                }
                            }
                            .padding(.vertical, 20)
                        }
                        .background(Color.white)
                        .frame(height: Globals.screen.height*0.4)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(radius: 10)
                        .edgesIgnoringSafeArea(.top)
                        
                        Text(viewModel.news.title)
                            .font(.system(.title))
                        Text(viewModel.news.content)
                            .font(.system(.body))
                            .padding()
                    }
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.store.dispatch(.closeNewsDetail)
                            }){
                                HStack {
                                    Image(systemName: "multiply")
                                        .foregroundColor(Color.gray)
                                }
                                .frame(width: 44, height: 44)
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(color: Color.gray.opacity(0.5), radius: 15, y: 15)
                            }
                            .padding()
                            .padding(.top, 20)
                        }
                        Spacer()
                    }
                }
            }.edgesIgnoringSafeArea(.all)
            
        }.animation(.spring())
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(viewModel: NewsViewModel.Sample(id: 2), show: .constant(true)).environmentObject(Store())
    }
}
