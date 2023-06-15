//
//  ImagePicker.swift
//  Stats Master
//
//  Created by KJ on 5/27/23.
//

import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    
    // for returning image at the end
    @Binding var imageToAdd: UIImage?
    
    // for dismissing this view\
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        
        // Create the image piker controller
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = context.coordinator
        imagePickerController.sourceType = .photoLibrary
        
        return imagePickerController
        
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        // create coordinator
        Coordinator(parent: self)
    }
    
    class Coordinator : NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        var parent: ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            // Check if we can get the image
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                
                // We were able to get the UIimage into the image constant
                // Pass this baclk to Team Image
                parent.imageToAdd = image
            }
            
            // Dismiss this view
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
}
