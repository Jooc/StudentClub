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
    
    var viewModel: Binding<NewsViewModel?>{
        self.$store.appState.detailedNews
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            if self.viewModel.wrappedValue != nil{
                content
                header
                    .offset(y: -80)
                    .edgesIgnoringSafeArea(.top)
            }
        }
    }
    
    var header: some View{
        HStack(alignment: .bottom, spacing: 10){
            KFImage(URL(string: Globals.OSSPrefix + viewModel.wrappedValue!.news.publisherInfo.avatar))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 65, height: 65)
                .clipShape(Circle())
                .padding(.top, 100)
                .padding(.all, 10)

            VStack(alignment:.leading, spacing: 5) {
                Text(viewModel.wrappedValue!.news.title)
                    .font(.title)
                    .lineLimit(1)
                Text(viewModel.wrappedValue!.news.publisherInfo.name)
                    .font(.subheadline)

            }.padding(.bottom)
            
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
            .padding(.bottom, 10)
        }
        .frame(width: Globals.screen.width, alignment: .leading)
        .frame(height: 180)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color.white)
                .shadow(radius: 10)
        )
    }

    var content: some View{
        ZStack {
            Color("Base")
            ScrollView(.vertical) {
                ZStack(alignment: .top) {
                    VStack(alignment: .center, spacing: 30) {

                        ScrollView(.horizontal, showsIndicators:false){
                            HStack {
                                ForEach(viewModel.wrappedValue!.news.images, id:\.self) { image in
                                    KFImage(URL(string: Globals.OSSPrefix + image))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: Globals.screen.width*0.9)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                        .padding(.horizontal, Globals.screen.width*0.05)
                                }
                            }
                            .padding(.vertical, 20)
                        }.padding(.top, 100)

                        Text(viewModel.wrappedValue!.news.content)
                            .font(.system(.body))
                            .padding()
                    }
                }
            }
        }.animation(nil)
    }
}

struct NewsDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail().environmentObject(Store.Sample())
    }
}

