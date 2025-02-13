//
//  Enums.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 12/02/2025.
//

import SwiftUI

enum CardBackgroundStyle {
    case white, blue, pink
    
    var color: Color {
        switch self {
        case .white: return .white
        case .blue: return Color(red: 0.2, green: 0.5, blue: 0.8).opacity(0.2)
        case .pink: return Color(red: 0.9, green: 0.4, blue: 0.6).opacity(0.2)
        }
    }
}
