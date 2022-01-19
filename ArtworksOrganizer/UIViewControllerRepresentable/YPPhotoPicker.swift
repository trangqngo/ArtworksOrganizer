//
//  ImagePickerNew.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 1/13/22.
//

import Foundation
import SwiftUI
import UIKit
import YPImagePicker

struct YPPhotoPicker: UIViewControllerRepresentable {
    
    @Binding var images: [UIImage?]
    @Binding var isShowingChosenImages: Bool
    
    class Coordinator: NSObject, YPImagePickerDelegate {
        
        var parent: YPPhotoPicker
        
        init(_ parent: YPPhotoPicker) {
            self.parent = parent
        }
        
        func imagePickerHasNoItemsInLibrary(_ picker: YPImagePicker) {
        
        }
        
        func shouldAddToSelection(indexPath: IndexPath, numSelections: Int) -> Bool {
            return false
        }
    }
    
    func makeUIViewController(context: Context) -> YPImagePicker {
        var config = YPImagePickerConfiguration()
        config.library.maxNumberOfItems = Int.max
        config.showsPhotoFilters = false
        config.shouldSaveNewPicturesToAlbum = true 
        let picker = YPImagePicker(configuration: config)
        picker.imagePickerDelegate = self.makeCoordinator()
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if cancelled {
                picker.dismiss(animated: true, completion: nil)
            } else {
                for item in items {
                    switch item {
                    case .photo(let photo):
                        images.append(photo.image)
                    case .video:
                        print("SHOULD NOT BE HERE")
                    }
                }
                isShowingChosenImages = true
                picker.dismiss(animated: false, completion: nil)
            }
         
            
            //picker.dismiss(animated: true, completion: nil)
        }
        
        return picker
       }

    func updateUIViewController(_ uiViewController: YPImagePicker, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    
    
}
