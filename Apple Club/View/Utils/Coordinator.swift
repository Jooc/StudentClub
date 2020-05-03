//
//  Coordinator.swift
//  Apple Club
//
//  Created by 齐旭晨 on 2020/5/1.
//  Copyright © 2020 齐旭晨. All rights reserved.
//

import SwiftUI

class Coordinator: NSObject,UINavigationControllerDelegate,  UIImagePickerControllerDelegate  {
    @Binding var isCoordinatorShow: Bool
    @Binding var imageInCoordinator: Image?
    
    init(isShown: Binding<Bool>, image: Binding<Image?>) {
        _isCoordinatorShow = isShown
        _imageInCoordinator = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else{ return }
        imageInCoordinator = Image(uiImage: unwrapImage)
        isCoordinatorShow = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isCoordinatorShow = false
    }
}
