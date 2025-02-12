//
//  ContentView.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 12/02/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CharacterListView(
            viewModel: CharacterListViewModel(
                serviceDI: ServiceDIContainer.shared
            )
        )
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
