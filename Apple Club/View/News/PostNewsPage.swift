//
//  PostNewsPage.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/5/1.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct PostNewsPage: View {
    @EnvironmentObject var store: Store
    
    var title: Binding<String>{
        self.$store.appState.postState.title
    }
    var content: Binding<String>{
        self.$store.appState.postState.content
    }
    //TODO: This might be binding too
    var image: Image?{
        self.store.appState.postState.image
    }
    var location: Binding<String>{
        self.$store.appState.postState.location
    }
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                header
                
                Spacer()
                
                VStack {
                    TextField("标题", text: title)
                    Divider()
                    TextField("正文", text: content)
                    
                    imagePad
                    
                    Divider()
                    TextField("地址", text: location)
                }
                
                Spacer()
            }
        }
        
    }
    var header: some View{
        HStack{
            Button("返回"){
                //TODO: return through dispatch
//                self.store.appState.
            }
            
            Spacer()
            
            Button(action:{
                
            }){
                Text("Post")
            }
        }.padding(.horizontal)
    }
    
    var imagePad: some View{
        image?
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 100, height: 100)
    }
}

struct PostNewsPage_Previews: PreviewProvider {
    static var previews: some View {
        PostNewsPage().environmentObject(Store())
    }
}
