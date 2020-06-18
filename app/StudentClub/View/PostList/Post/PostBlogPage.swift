//
//  PostBlogPage.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/17.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct PostBlogPage: View {
    @EnvironmentObject var store: Store
    
    var body: some View{
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical){
                VStack(spacing: 50) {
                    HStack{
                        Button(action: {
                            self.store.appState.upSliderPageState = .NONE
                        }){
                            Text("取消")
                                .foregroundColor(Color.black)
                        }
                        
                        Spacer()
                        
                        Button(action:{
                            self.store.dispatch(.postBlog)
                        }){
                            Text("发布")
                                .foregroundColor(Color.white)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .background(Color.green)
                                .cornerRadius(5)
                        }
                    }
                    .padding(.horizontal)
                    
                    TextField("URL", text: self.$store.appState.postState.blogURL)
                        .padding()
                    
                    HStack {
                        Spacer()
                        Button(action:{
                            self.store.dispatch(.loadPostingBlogLPMetaData)
                        }){
                            Text("预览")
                        }.padding(.trailing)
                    }
                    
                    Spacer()
                    
                    RichLinkView(metaData: store.appState.postState.blogMetaData)
                        .frame(maxWidth: Globals.screen.width*0.9)
                    
                    Spacer()
                }
            }
        }
    }
}

struct PostBlogPage_Previews: PreviewProvider {
    static var previews: some View {
        PostBlogPage().environmentObject(Store.Sample())
    }
}
