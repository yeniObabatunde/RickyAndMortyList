//
//  FilterButton.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 12/02/2025.
//

import SwiftUI

struct FilterButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.black : Color.clear)
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
    }
}

#Preview {
    FilterButton(title: "Click Me", isSelected: true, action: { 
        
    })
}
