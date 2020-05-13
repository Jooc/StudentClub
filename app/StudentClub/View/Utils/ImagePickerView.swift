//
//  ImagerPicker.swift
//  StudentClub
//
//  Created by 齐旭晨 on 2020/5/1.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

struct ImagePickerView:  UIViewControllerRepresentable{
    @Binding var isPresented: Bool
    @Binding var image: Image?
//    @Binding var showPostNewsPage: Bool
    
    var sourceType: UIImagePickerController.SourceType
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        controller.sourceType = sourceType
        controller.allowsEditing = true
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: UIViewControllerRepresentableContext<ImagePickerView>) {
            
    }
}

class Coordinator: NSObject,UINavigationControllerDelegate,  UIImagePickerControllerDelegate  {
    let parent: ImagePickerView
    
    init(parent: ImagePickerView) {
        self.parent = parent
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            parent.image = Image(uiImage: unwrapImage)
        }
        self.parent.isPresented = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.parent.isPresented = false
    }
}
