//
//  CachedAsyncImage.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL?
    
    @State private var image: Image?
    @State private var isLoading = true
    
    var body: some View {
        Group {
            if let image = image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                Color.gray.opacity(0.3)
                    .overlay {
                        if isLoading {
                            ProgressView()
                        }
                    }
            }
        }
        .task {
            await loadImage()
        }
    }
    
    private func loadImage() async {
        guard let url = url else { return }
        
        do {
            let uiImage = try await ImageLoadingService.shared.loadImage(from: url)
            image = Image(uiImage: uiImage)
        } catch {
            image = Image("defaultImage")
        }
        isLoading = false
    }
}
