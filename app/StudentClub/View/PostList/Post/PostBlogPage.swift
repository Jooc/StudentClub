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
    
    var body: some View {
        header
    }
    
    var header: some View{
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
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
                
                Spacer()
            }
        }
    }
}

struct PostBlogPage_Previews: PreviewProvider {
    static var previews: some View {
        PostBlogPage().environmentObject(Store())
    }
}
