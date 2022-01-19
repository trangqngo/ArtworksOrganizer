//
//  EmptyGalleryView.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 1/18/22.
//

import SwiftUI

struct EmptyGalleryView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Text("Your gallery is empty.")
                .font(.headline)
            Spacer()
        }
    }
}

struct EmptyGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyGalleryView()
    }
}
