//
//  EditArtwork.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/13/21.
//

//clear chosenImages after done with edit views 
import SwiftUI

struct ChosenImagesView: View {
    
    @EnvironmentObject var artworkData: ArtworkData
    
    @State var tempEdited =  [Int: (MainInformation, UIImage)]()
    
    //pre: images has at least 1 element
    @Binding var images: [UIImage?]
    @Binding var isShowing: Bool

    
    var body: some View {
        
        TabView {
            ForEach(images.indices) {i in
                AddSingleArtwork(tempEdited: $tempEdited, index: i, image: images[i]!)
                }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    for i in images.indices {
                        if let (mainInfo, image) = tempEdited[i] {
                            artworkData.addArtwork(mainInfo: mainInfo, image: image)
                        } else {  //users did not view this image - save the original (no edit) img and empty main information
                            artworkData.addArtwork(mainInfo: MainInformation(artist: "", title: "", material: "", description: ""), image: images[i]!)
                        }
                        
                    }
                    isShowing = false
                } label: {
                    Text("Save")
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isShowing = false 
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(Color("Text"))
                }
            }
        }
    }
}
            

//struct ChosenImagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditArtwork()
//    }
//}
