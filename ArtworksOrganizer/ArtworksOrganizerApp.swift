//
//  ArtworksOrganizerApp.swift
//  ArtworksOrganizer
//
//  Created by Trang Quynh Ngo on 12/13/21.
//

import SwiftUI


@main
struct ArtworksOrganizerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomefeedView()
                    .environmentObject(ArtworkData())
            }
            .accentColor(Color("Text"))
        }
    }
}
