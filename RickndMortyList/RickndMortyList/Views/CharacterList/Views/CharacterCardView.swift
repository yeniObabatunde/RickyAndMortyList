//
//  CharacterCardView.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 12/02/2025.
//

import SwiftUI

struct CharacterCardView: View {
    
    let character: CharacterModel
    let backgroundStyle: CardBackgroundStyle
    
    var body: some View {
        HStack(spacing: 16) {
            CachedAsyncImage(url: character.imageURL)
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text(character.name ?? "")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Text(character.species ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(20)
        .background(
            Group {
                if backgroundStyle == .white {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(backgroundStyle.color)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(backgroundStyle.color)
                }
            }
            
        )
        
        .cornerRadius(12)
    }
}

#Preview {
    CharacterCardView(character: mockCharacters[0], backgroundStyle: .pink)
}

