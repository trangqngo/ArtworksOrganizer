//
//  EditSingleArtwork.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/16/21.
//

import SwiftUI

struct AddSingleArtwork: View {
    
    @EnvironmentObject var artworkData: ArtworkData

    @State private var mainInfo: MainInformation = MainInformation(artist: "", title: "", material: "", description: "")
    
    @Binding var tempEdited: [Int: (MainInformation, UIImage)]
    
    var index: Int
    
    @State var image: UIImage
   
    @State var isShowingEditor = false
    
    var body: some View {
        VStack {
            
            Button(action: {
                isShowingEditor = true
            }, label: {
                //Have to obverlay symbol editing on bottom left of image here
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
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
                TextEditor(text: $mainInfo.description)
            }
        }
        .fullScreenCover(isPresented: $isShowingEditor) {
            ImageEditor(image: $image, isShowing: $isShowingEditor)
        }
        //does not cover case where user doesnt edit either image/ info
        //this case will be handled in the parent view
        .onChange(of: mainInfo) {_ in
            tempEdited[index] = (mainInfo, image)
        }
        .onChange(of: image) {_ in
            tempEdited[index] = (mainInfo, image)
        }
    }
}

//struct AddSingleArtwork_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSingleArtwork()
//    }
//}

