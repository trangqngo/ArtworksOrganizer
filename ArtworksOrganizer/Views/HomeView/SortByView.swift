import SwiftUI

struct SortByView: View {
    
    @EnvironmentObject var artworkData: ArtworkData
    
    var sortBy: [String:Int] //a frequency dict
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(Array(sortBy.keys).sorted(), id: \.self) { item in
                    NavigationLink {
                        GalleryGridView(artworks: artworkData.byItem(type: .artist, item: item), spacing: 10)
                            .environmentObject(artworkData)
                    } label: {
                        SortThumbnailView(item: item, thumbnail: artworkData.imageByArtist(artist: item))
                    }

                }
            }
            .padding(.horizontal)
            .onAppear {
                artworkData.loadArtworks()
            }
        }
    }
}

struct SortThumbnailView: View {
    
    var item: String
    
    var thumbnail: UIImage
    
    var body: some View {
        ZStack {
            Rectangle()
                .aspectRatio(1, contentMode: .fit)
                .overlay(
                    Image(uiImage: thumbnail)
                        .resizable()
                        .scaledToFill()
                        
                )
                .clipShape(Rectangle())
                .opacity(0.35)
            
            Text(item == "" ? "Unknown" : item)
                .font(.headline)
        }
        
    }


}
//
//struct SortByView_Previews: PreviewProvider {
//    static var previews: some View {
//        SortByView(so)
//    }
//}
