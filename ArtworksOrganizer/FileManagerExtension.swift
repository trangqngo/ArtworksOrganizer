//
//  FileManagerExtension.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/13/21.
//

import Foundation
import SwiftUI

extension FileManager {
    // hackingwithswift
    var documentDirectory: URL {
        // find all possible documents directories for this user
        let paths = Self.default.urls(for: .documentDirectory, in: .userDomainMask)

        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
    var artworksFile: URL {
        documentDirectory
            .appendingPathComponent("MyArtworksOrganizer")
            .appendingPathExtension(for: .json)
    }

//    
//    func saveImage(_ id: String, image: UIImage) {
//        if let data = image.jpegData(compressionQuality: 0.6) {
//            let imageURL = documentDirectory.appendingPathComponent("\(id).jpeg")
//            do {
//                try data.write(to: imageURL)
//            } catch {
//                fatalError("Could not save image, please reinstall app.")
//            }
//        } else {
//            fatalError("Could not save image, please reinstall app.")
//        }
//    }
//

    func loadImage(id: String) -> UIImage? {
        let imageURL = documentDirectory.appendingPathComponent("\(id).jpeg")
        if fileExists(atPath: imageURL.path) {
            return UIImage(contentsOfFile: imageURL.path)
        }
        return nil
    }
}
