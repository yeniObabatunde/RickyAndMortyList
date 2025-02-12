//
//  CharacterFilterView.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 12/02/2025.
//

import SwiftUI

struct CharacterFilterView: View {
    @Binding var selectedStatus: CharacterStatus?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(CharacterStatus.allCases, id: \.self) { status in
                    FilterButton(
                        title: status.rawValue,
                        isSelected: selectedStatus == status
                    ) {
                        selectedStatus = status
                        
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct CharacterFilterView_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedStatus: CharacterStatus? = .alive
        CharacterFilterView(selectedStatus: $selectedStatus)
    }
}
