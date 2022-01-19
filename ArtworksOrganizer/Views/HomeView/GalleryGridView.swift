import SwiftUI
import UIKit

//A waterfall grid of artworks
//
struct GalleryGridView: View {

    @EnvironmentObject var artworkData: ArtworkData
    
  //  @Binding var artworks: [Artwork]
    var artworks: [Artwork]
    
   // @State var sortBy: String = ""
    
    //var sortOptions = ["Artist", "Material"]

    //var artworks: [Artwork]
    var columns: Int = 2
    var spacing: CGFloat

    // [ [imgs in col1] , [imgs in col2], ..]
//    var gridList: [ArtworkArray] {
//        //2 columns
//        var grid: [ArtworkArray] = [ArtworkArray(id: 0), ArtworkArray(id: 1)]
//        var current: Int = 0
//        for artwork in artworkData.artworks {
//            grid[current].artworkArray.append(artwork)
//            current = (current+1)%columns
//        }
//        return grid
//    }
    
    var gridList: [ArtworkArray] {
        //2 columns
        var grid: [ArtworkArray] = [ArtworkArray(id: 0), ArtworkArray(id: 1)]
        var current: Int = 0
        for artwork in artworks {
            grid[current].artworkArray.append(artwork)
            current = (current+1)%columns
        }
        return grid
    }


    var body: some View {
        
//        if artworkData.artworks.count == 1 {
//            Text("The gallery is empty")
//        } else {
//            VStack {
//                ScrollView(.vertical, showsIndicators: true)  {
//                    HStack(alignment: .top, spacing: spacing) {
//                        ForEach(gridList, id: \.id) {artworkArray in
//                            VStack {
//                                ForEach(artworkArray.artworkArray.reversed(), id: \.imageId) {artwork in
//                                    if artworkData.artworkWithIdExists(imageId: artwork.imageId) != -1 {
//                                        ComponentView(artwork: artwork)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                    .padding(.horizontal, spacing)
//                }
//            }
//        }
        
        if artworks.count == 1 && artworks[0].imageId == "dummy" {
            Text("The gallery is empty")
        } else {
            VStack {
                ScrollView(.vertical, showsIndicators: true)  {
                    HStack(alignment: .top, spacing: spacing) {
                        ForEach(gridList, id: \.id) {artworkArray in
                            VStack {
                                ForEach(artworkArray.artworkArray.reversed(), id: \.imageId) {artwork in
                                    if artworkData.artworkWithIdExists(imageId: artwork.imageId) != -1 {
                                        ComponentView(artwork: artwork)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, spacing)
                }
            }
        }
        
    }
}

// This struct helps make sure the gallery view (and component view) dont reload, making navlink pop

struct ArtworkArray: Identifiable {
    var id: Int
    var artworkArray = [Artwork]()
}

//view of a single artwork
struct ComponentView: View {
    
    @EnvironmentObject private var artworkData: ArtworkData
    
    var artwork: Artwork
    
    @ViewBuilder
    var body: some View {
        if artworkData.artworkWithIdExists(imageId: artwork.imageId) != -1 && artwork.imageId != "dummy" {
            NavigationLink(destination: SingleArtworkView(artwork: binding(for: artwork)).environmentObject(artworkData)) {
            //NavigationLink(destination: SingleArtworkView(imageId: imageId).environmentObject(artworkData)) {
                Image(uiImage: artwork.image)
                 .resizable()
                 .aspectRatio(contentMode: .fit)
                 .cornerRadius(5)
            }
            .environmentObject(artworkData)
            .onAppear {
                artworkData.loadArtworks()
            }
        } else if artwork.imageId == "dummy" {
            Image(systemName: "photo.fill")
                .resizable()
                .frame(height: 0.01)
                .background(Color("Background"))
        }
    }
}

extension ComponentView {

    //pre: this artwork exists
    func binding(for artwork: Artwork) -> Binding<Artwork> {
       // print("FINDING: \(artwork.imageId)")
        let index = artworkData.artworkWithIdExists(imageId: artwork.imageId)
        return $artworkData.artworks[index]
    }
}


