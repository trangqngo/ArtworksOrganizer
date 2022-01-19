//
//  EditArtworkView.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/22/21.
//

import SwiftUI
import UIKit

struct EditArtworkView: View {
    
    @Environment(\.presentationMode) var mode
    
    @EnvironmentObject private var artworkData: ArtworkData
    
    @State private var isShowingEditor = false
    @Binding var artwork: Artwork
    
    @State var mainInfo: MainInformation
    
    @State private var newImage = UIImage()

    init(artwork: Binding<Artwork>, mainInfo: MainInformation) {
        self._artwork = artwork
        self._mainInfo = State(initialValue: mainInfo)
    }
    
    var body: some View {
//        NavigationView {
            VStack {
                    
                    Button(action: {
                        isShowingEditor = true
                        //if this is the first time editing this image
                        if newImage.isEqual(UIImage()) {
                            newImage = artwork.image
                        }
                    }, label: {
                        //Have to obverlay symbol editing on bottom left of image here
                        if !newImage.isEqual(UIImage()) {
                            Image(uiImage: newImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .overlay(
                                    Image(systemName: "pencil.circle")
                                        .font(.system(size: 20))
                                        .padding(10),
                                    alignment: .bottomTrailing
                                )
                        } else {
//                            Image(uiImage: artwork.image)
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
                            
                            Image(uiImage: artwork.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .overlay(
                                    Image(systemName: "pencil.circle")
                                        .font(.system(size: 20))
                                        .padding(10),
                                    alignment: .bottomTrailing
                                )
                        }
                    })

                    Spacer()
                    
                    Form {
                        TextField("Artist", text: Binding(
                            get: { self.mainInfo.artist },
                            set: {
                                self.mainInfo.artist = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                        }))
                        TextField("Title", text: Binding(
                            get: { self.mainInfo.title },
                            set: {
                                self.mainInfo.title = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                        }))
                        TextField("Material", text: Binding(
                            get: { self.mainInfo.material },
                            set: {
                                self.mainInfo.material = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                        }))
                        TextField("Description", text: $mainInfo.description)
                    }
                }
                    
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        artworkData.updateMainInfo(mainInfo: mainInfo, imageId: artwork.imageId)
                        artworkData.saveImageWithId(image: newImage, id: artwork.imageId)
                        artworkData.saveArtworks()
                        mode.wrappedValue.dismiss()
                    }
                }
            }
        
        
                .fullScreenCover(isPresented: $isShowingEditor) {
                    ImageEditor(image: $newImage, isShowing: $isShowingEditor)
                }
             
    }
}


//struct EditArtworkView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditArtworkView()
//    }
//}
