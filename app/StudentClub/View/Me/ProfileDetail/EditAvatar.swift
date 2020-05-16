//
//  EditAvatar.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/7.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct EditAvatar: View {
    @EnvironmentObject var store: Store
    @State var newImage: Image? = nil
    @State var showPhotoPicker: Bool = false
    
    var user: User{
        self.store.appState.loginState.user ?? User.Sample()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack{
                    Button(action:{
                        self.store.appState.meState.editAvatar = false
                    }){
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color.white)
                            .padding(.all, 5)
                    }
                    
                    Spacer()
                    Text("头像")
                        .foregroundColor(Color.white)
                    Spacer()
                    
                    Button(action:{
                        self.showPhotoPicker = true
                    }){
                        Text("···")
                            .font(.system(size: 30))
                            .foregroundColor(Color.white)
                    }
                    .actionSheet(isPresented: $showPhotoPicker){
                        ActionSheet(title: Text("Photos"), buttons: [
                            ActionSheet.Button.default(Text("相机")){
                                //                    self.store.appState.showCamera = true
                            },
                            ActionSheet.Button.default(Text("从相册选择")){
                                //                    self.store.appState.showPhotoLibrary = true
                            },
                            ActionSheet.Button.cancel()
                        ])
                    }
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 10)
                
                Spacer()
                
                KFImage(URL(string: user.avatar))
                .resizable()
                .aspectRatio(contentMode: .fit)
                
                Spacer()
            }
        }

    }
}

struct EditAvatar_Previews: PreviewProvider {
    static var previews: some View {
        EditAvatar().environmentObject(Store())
    }
}
