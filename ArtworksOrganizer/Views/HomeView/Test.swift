//
//  Test.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 1/19/22.
//

import SwiftUI

struct Test: View {
    var body: some View {
        Image(systemName: "photo.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .overlay(
                Image(systemName: "pencil.circle")
                    .font(.system(size: 15))
                    .padding(20),
                alignment: .bottomTrailing
            )
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
