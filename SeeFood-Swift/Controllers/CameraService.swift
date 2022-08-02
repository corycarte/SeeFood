//
//  CameraService.swift
//  SeeFood-Swift
//
//  Created by Cory Carte on 7/30/22.
//

import SwiftUI
import UIKit
import PhotosUI

struct CameraService: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    typealias UIViewControllerType = UIImagePickerController
    
    let sourceType: UIImagePickerController.SourceType
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
}

//MARK: - Coordinator
extension CameraService {
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraService
        
        init(_ p: CameraService) {
            self.parent = p
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let userPickedImage = info[.originalImage] as? UIImage {
                print("Loading image")
                self.parent.image = userPickedImage
            }
                        
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func makeCoordinator() -> Coordinator { return Coordinator(self) }
}
