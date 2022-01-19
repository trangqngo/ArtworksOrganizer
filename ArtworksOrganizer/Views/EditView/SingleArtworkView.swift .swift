//
//  SingleArtworkView.swift .swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/22/21.
//

import SwiftUI

struct SingleArtworkView: View {
    
    @Environment(\.presentationMode) var mode
    
    @EnvironmentObject var artworkData: ArtworkData
    @Binding var artwork: Artwork
    
    @State private var isShowingMainInfo = false
    
    @State private var scale: CGFloat = 1
    
    @State private var isShowingAlert = false //alert for delete
  
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            VStack {
                Spacer()
                ZoomableScrollView {
                    Image(uiImage: artwork.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 5)
                }
            
                Button {
                    isShowingMainInfo = true
                } label: {
                    VStack {
                        Text("view information")
                            .font(.footnote)
                            .padding(.bottom, 5)
                            .foregroundColor(isShowingMainInfo ? Color("Background") : Color("Text"))
                        Image(systemName: "chevron.up.circle.fill")
                            .foregroundColor(isShowingMainInfo ? Color("Background") : Color("Text"))
                            .font(.system(size: 20))
                    }
                }.padding(.bottom, 20)

                Spacer()
            }
            .sheet(isPresented: $isShowingMainInfo) {
                ZStack {
                    Color("Background").opacity(0.3)
                                   .background(TransparentBackground())
                    VStack {
                        Spacer()
                        MainInfoView(artwork: $artwork)
                            .padding(.bottom, 20)
                            .padding(.horizontal, 5)
                        Button {
                            isShowingMainInfo = false
                        } label: {
                            Image(systemName: "chevron.down.circle.fill")
                                .foregroundColor(Color("Text"))
                                .font(.system(size: 20))
                        }.padding(.bottom, 40)
                    }
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        NavigationLink("Edit", destination: EditArtworkView(artwork: $artwork, mainInfo: artwork.mainInfo).environmentObject(artworkData))
                        
                        Button(action: {
                            isShowingAlert = true
                        }, label: {
                            Image(systemName: "trash")
                        })
                        .alert(isPresented: $isShowingAlert) {
                            Alert(
                                title: Text("Are you sure you want to delete this?"),
                                primaryButton: .destructive(Text("Delete")) {
                                    artworkData.deleteArtwork(imageId: artwork.imageId)
                                    artworkData.loadArtworks()
                                    mode.wrappedValue.dismiss()
                                },
                                secondaryButton: .cancel()
                                )
                        }
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(artworkData)
    }
}


struct TransparentBackground: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
            let view = UIView()
            DispatchQueue.main.async {
                view.superview?.superview?.backgroundColor = .clear
            }
            return view
        }

        func updateUIView(_ uiView: UIView, context: Context) {}
}

struct MainInfoView: View {
    
   @Binding var artwork: Artwork
    
    var body: some View {
        VStack (alignment: .leading) {
            
            Text(artwork.mainInfo.artist == "" ? "Artist" : artwork.mainInfo.artist)
                .fontWeight(.bold)
                .padding(.horizontal, 10)
                .foregroundColor(artwork.mainInfo.artist == "Artist" ? Color("Text-info-card-blank") : Color("Text-info-card"))
            Text(artwork.mainInfo.title == "" ? "Title" : artwork.mainInfo.title)
                .fontWeight(.bold)
                .padding(.horizontal, 10)
                .foregroundColor(artwork.mainInfo.title == "Title" ? Color("Text-info-card-blank") : Color("Text-info-card"))
            Text(artwork.mainInfo.material == "" ? "Material" : artwork.mainInfo.material)
                .italic()
                .padding(.horizontal, 10)
                .foregroundColor(artwork.mainInfo.material == "Material" ? Color("Text-info-card-blank") : Color("Text-info-card"))
            Text(artwork.mainInfo.description == "" ? "Description" : artwork.mainInfo.description)
                .font(.footnote)
                .fontWeight(.thin)
                .foregroundColor(artwork.mainInfo.artist == "Description" ? Color("Text-info-card-blank") : Color("Text-info-card"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
        }
        .frame(width: 200)
        .padding(.vertical, 5)
        .background(Color("Info-card"))
    }
}

//struct SingleArtworkView_Previews: PreviewProvider {
//    static var previews: some View {
//        //SingleArtworkView(artwork)
//        SingleArtworkView()
//    }
//}
