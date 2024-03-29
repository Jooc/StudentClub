//
//  PostNewsPage.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/1.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct PostNewsPage: View {
    @EnvironmentObject var store: Store
    
    var pickImageActionSheet: Binding<Bool>{
        self.$store.appState.postState.pickImageActionSheet
    }
    
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                header
                
                VStack {
                    TextField("标题", text: self.$store.appState.postState.title)
                        .padding(.vertical)
                    Divider()
                    TextField("正文", text: self.$store.appState.postState.content)
                        .padding(.vertical)
                    
                    imagePad
                        .padding(.bottom, 200)
                    
                    Divider()
                    TextField("标签", text: self.$store.appState.postState.tags)
                    Spacer()
                }.padding(.horizontal)
                Spacer()
            }
            
            if self.store.appState.postState.showCamera{
                ImagePickerView(
                    isPresented: self.$store.appState.postState.showCamera,
                    image: self.$store.appState.postState.image,
                    sourceType: .camera)
                    .edgesIgnoringSafeArea(.all)
            }
            if self.store.appState.postState.showPhotoLibrary{
                ImagePickerView(
                    isPresented: self.$store.appState.postState.showPhotoLibrary,
                    image: self.$store.appState.postState.image,
                    sourceType: .photoLibrary)
                    .edgesIgnoringSafeArea(.all)
            }
        }
        .actionSheet(isPresented: pickImageActionSheet){
            ActionSheet(title: Text("Photos"), buttons: [
                ActionSheet.Button.default(Text("Camera")){
                    self.store.appState.postState.showCamera = true
                },
                ActionSheet.Button.default(Text("Choose from Album")){
                    self.store.appState.postState.showPhotoLibrary = true
                },
                ActionSheet.Button.cancel()
            ])
        }
    }
    
    var header: some View{
        HStack{
            Button(action: {
                self.store.appState.upSliderPageState = .NONE
            }){
                Text("取消")
                    .foregroundColor(Color.black)
            }
            
            Spacer()
            
            Button(action:{
                self.store.dispatch(.postNews)
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
    }
    
    var imagePad: some View{
        ScrollView(.horizontal){
            HStack {
                if self.store.appState.postState.image != nil{
                    Image(uiImage: self.store.appState.postState.image!)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
                
                Image(systemName: "plus")
                    .font(.system(size: 30))
                    .foregroundColor(Color.gray)
                    .frame(width: 100, height: 100)
                    .background(Color.gray.opacity(0.1))
                    .onTapGesture {
                        self.store.appState.postState.pickImageActionSheet = true
                }
            }
        }
    }
}

struct PostNewsPage_Previews: PreviewProvider {
    static var previews: some View {
        PostNewsPage().environmentObject(Store())
    }
}
