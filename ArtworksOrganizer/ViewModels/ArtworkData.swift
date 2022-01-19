//
//  ArtworkData.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/13/21.
//

import Foundation
import SwiftUI
import UIKit

class ArtworkData: ObservableObject {
    @Published var artworks: [Artwork] = []
    
    //stores all artists and the frequencies of their artworks
    //is not persistent - gets initiated everytime artworks is loaded
    @Published var artists: [String:Int] = [:]
    
    
    //FOR SORTING - view folder-style 
    enum sortBy {
        case artist
    }
    
    //returns image of artwork by given artist
    func imageByArtist(artist: String) -> UIImage {
        for artwork in artworks {
            if artwork.mainInfo.artist.trimmingCharacters(in: .whitespacesAndNewlines) ==
                artist.trimmingCharacters(in: .whitespacesAndNewlines) {
                return artwork.image
            }
        }
        return UIImage(systemName: "photo.fill")!
    }
    
    //returns all artworks with given type matching item
    //eg: type: artist, item: Van Gogh - returns all artworks by Van Gogh
    func byItem(type: sortBy, item: String) -> [Artwork] {
        switch type {
        case .artist:
            return artworks.filter {$0.mainInfo.artist == item}
        }
    }
//    //returns all artworks with given artistName
//    func byArtist(artist: String) -> [Artwork] {
//        artworks.filter {$0.mainInfo.artist == artist}
//    }
    
    //functions for the global artist list
    func initArtists() {
        artists.removeAll()
        for artwork in artworks {
            addArtist(name: artwork.mainInfo.artist.trimmingCharacters(in: .whitespacesAndNewlines))
        }
        //account for dummy artwork
        removeArtist(name: "")
    }
    
    func addArtist(name: String) {
        if let freq = artists[name] {
            artists[name] = freq+1
        } else {
            artists[name] = 1
        }
    }
    
    func removeArtist(name: String) {
        if let freq = artists[name] {
            if freq == 1 {
                artists.removeValue(forKey: name)
            } else {
                artists[name] = freq - 1
            }
        } else {//trying to remove an artist that is not in the global list
            
        }
    }
    
    //check to see if data is saved into document directory
    init() {
        print(FileManager().documentDirectory)
    }

    func loadArtworks() {
        let dummy = Artwork(imageId: "dummy", mainInfo: MainInformation(artist: "", title: "", material: "", description: ""))
        guard let data = try? Data(contentsOf: FileManager().artworksFile) else { return }
        do {
            let savedArtworks = try JSONDecoder().decode([Artwork].self, from: data)
            artworks = savedArtworks
            artworks = artworks.filter {$0.imageId != "dummy"}
            artworks.append(dummy)
            initArtists()
            //print("LIST OF ARTISTS: \(artists)")
            //print("ART: \(artworks)")
            
        } catch {
            fatalError("An error occured while loading images: \(error)")
        }
    }


    //adds a new artwork 
    func addArtwork(mainInfo: MainInformation, image: UIImage) {
        let id = saveImage(image: image)
        let newArtwork = Artwork(imageId: id, mainInfo: mainInfo)
        artworks.append(newArtwork)
        //adds name of artist
        addArtist(name: newArtwork.mainInfo.artist)
        saveArtworks()
    }
    
    //updates a new mainInfo for an artwork given its imageId
    func updateMainInfo(mainInfo: MainInformation, imageId: String) {
        for index in artworks.indices {
            //updates global list of artists
            if imageId == artworks[index].imageId {
                removeArtist(name: artworks[index].mainInfo.artist)
                addArtist(name: mainInfo.artist.trimmingCharacters(in: .whitespacesAndNewlines))
                artworks[index].mainInfo = mainInfo
                return
            }
        }
        fatalError("An error occured while saving data.")
    }
    
    //deletes an artwork (as well as the image)
    func deleteArtwork(imageId: String) {
        for index in artworks.indices {
            if imageId == artworks[index].imageId {
                removeArtist(name: artworks[index].mainInfo.artist)
                artworks.remove(at: index)
                deleteImage(id: imageId)
                saveArtworks()
                return
            }
        }
        fatalError("An error occured while deleting this")
    }
    
    //saves all artworks
    func saveArtworks() {
        do {
            let encodedData = try JSONEncoder().encode(artworks)
            try encodedData.write(to: FileManager().artworksFile)
        } catch {
            fatalError("An error occured while saving data: \(error)")
        }
    }
    
    //image of this artwork has been changed: deletes old image and
    //saves new image under same imageId
    func saveImageWithId(image: UIImage, id: String) {
        if let data = image.jpegData(compressionQuality: 0.6) {
            let imageURL = FileManager().documentDirectory.appendingPathComponent("\(id).jpeg")
            do {
                try FileManager.default.removeItem(at: imageURL)
            } catch {
                fatalError("An error occured while saving the new image: \(error)")
            }
            do {
                try data.write(to: imageURL)
            } catch {
                fatalError("An error occured while saving the new image: \(error)")
            }
        }
    }
    
    //deletes an image
    func deleteImage(id: String) {
        let imageURL = FileManager().documentDirectory.appendingPathComponent("\(id).jpeg")
        do {
            try FileManager.default.removeItem(at: imageURL)
        } catch {
            fatalError("An error occured while deleting this image: \(error)")
        }
        
    }
    
    //saves a new image
    func saveImage(image: UIImage) -> String {
        if let data = image.jpegData(compressionQuality: 0.6) {
            let id = UUID().uuidString
            let imageURL = FileManager().documentDirectory.appendingPathComponent("\(id).jpeg")
            do {
                try data.write(to: imageURL)
                return id
            } catch {
                fatalError("Could not save image, please reinstall app.")
            }
        } else {
            fatalError("Could not save image, please reinstall app.")
        }
    }
    
    //given an imageId, returns whether an artwork exists
    func artworkWithIdExists(imageId: String) -> Int {
        for index in artworks.indices {
            if imageId == artworks[index].imageId {
                return index
            }
        }
        return -1
    }

//
//    func binding(for artwork: Artwork) -> Binding<Artwork> {
//       // print("FINDING: \(artwork.imageId)")
//        let index = artworkData.artworkWithIdExists(imageId: artwork.imageId)
//        return $artworkData.artworks[index]
//    }
    
    
}


