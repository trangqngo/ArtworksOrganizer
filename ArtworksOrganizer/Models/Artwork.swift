//
//  Artwork.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/13/21.
//

import Foundation
import UIKit

struct Artwork: Codable, Hashable {
    var imageId: String //id of the artwork image
    var mainInfo: MainInformation
    
    var image: UIImage {
        if let image = FileManager().loadImage(id: "\(imageId)") {
            return image
        } else {//returns a filler image
            return UIImage(systemName: "photo.fill")!
        }
    }
}

struct ArtImage {
    var id: String 
    var image: UIImage
}

struct MainInformation: Codable, Hashable, Equatable {
    var artist: String = ""
    var title: String = ""
    var material: String = ""
    var description: String = ""
    
    init(artist: String, title: String, material: String, description: String) {
        self.artist = artist.trimmingCharacters(in: .whitespacesAndNewlines)
        self.title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        self.material = material.trimmingCharacters(in: .whitespacesAndNewlines)
        self.description = description
    }
}
