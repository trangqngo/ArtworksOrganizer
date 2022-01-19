//
//  ContentView.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/13/21.
//

import SwiftUI
import YPImagePicker
import UIKit

struct HomefeedView: View {
    
    //for sort views
    @State var selectedView: ViewEnum = .timeView//for sort views
    
    @EnvironmentObject private var artworkData: ArtworkData
    
    @State var isShowingImagesPicker = false

    @State var chosenImages: [UIImage?] = []
    
    @State var isShowingChosenImages = false 
    
    var body: some View {
            VStack {
                //only has the filler image
                if artworkData.artworks.count == 1 {
                    EmptyGalleryView()
                } else {
                    displayView(selectedView)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                HStack {
                                    Text("Sort by")
                                    Picker("Sort by", selection: $selectedView) {
                                        Text("Time added").tag(ViewEnum.timeView)
                                        Text("Artist").tag(ViewEnum.artistView)
                                    }
                                }
                            }
                        }
                        
                    
                }
                Spacer()
                Button {
                    isShowingImagesPicker = true
                    chosenImages = []
                    UIView.setAnimationsEnabled(false)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color("Text"))
                        .font(.system(size: 35))
                }
            }
            .navigationTitle("My Gallery")
        
            .fullScreenCover(isPresented: $isShowingImagesPicker) {
                YPPhotoPicker(images: $chosenImages, isShowingChosenImages: $isShowingChosenImages)
                    .environmentObject(artworkData)
            }
            .onAppear {
                UIView.setAnimationsEnabled(true)
                artworkData.loadArtworks()
            }
        
            .fullScreenCover(isPresented: $isShowingChosenImages) {
                NavigationView {
                    ChosenImagesView(images: $chosenImages, isShowing: $isShowingChosenImages)
                        .navigationTitle("")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
    }
    
    @ViewBuilder
    func displayView(_ selectedView: ViewEnum) -> some View {
        switch selectedView {
        case .timeView:
            GalleryGridView(artworks: artworkData.artworks, spacing: 10)
                        .environmentObject(artworkData)
        case .artistView:
            SortByView(sortBy: artworkData.artists).environmentObject(artworkData)
        }
    }
}

enum ViewEnum {
    case timeView, artistView
}

//
//
//
//struct HomefeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomefeedView()
////            .environmentObject(ImagePickerViewModel())
//    }
//}
