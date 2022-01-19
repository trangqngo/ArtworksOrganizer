//
//  ImageEditor.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/15/21.
//

import Foundation
import Mantis
import SwiftUI

struct ImageEditor: UIViewControllerRepresentable {
    typealias Coordinator = ImageEditorCoordinator
    
    //image is not optional because imageEditor is only instantiated when at least one image is chosen 
    @Binding var image: UIImage
    @Binding var isShowing: Bool
    
    func makeCoordinator() -> ImageEditorCoordinator {
        return ImageEditorCoordinator(image: $image, isShowing: $isShowing)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageEditor>) -> Mantis.CropViewController {
        let cropViewController = Mantis.cropViewController(image: image)
        cropViewController.delegate = context.coordinator
        return cropViewController
    }
    
}

class ImageEditorCoordinator: NSObject, CropViewControllerDelegate {
    @Binding var image: UIImage
    @Binding var isShowing: Bool
    
    init(image: Binding<UIImage>, isShowing: Binding<Bool>) {
        _image = image
        _isShowing = isShowing
    }
    
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation) {
        image = cropped
        isShowing = false
    }
    
    func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {
        
    }
    
    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        isShowing = false
    }
    
    func cropViewControllerDidBeginResize(_ cropViewController: CropViewController) {
        
    }
    
    func cropViewControllerDidEndResize(_ cropViewController: CropViewController, original: UIImage, cropInfo: CropInfo) {
        
    }
    
    
}
