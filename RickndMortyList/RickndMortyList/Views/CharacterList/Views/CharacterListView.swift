//
//  CharacterListView.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 12/02/2025.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel: CharacterListViewModel
    @State private var navigationPath = NavigationPath()
    
    init(viewModel: CharacterListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 16) {
                    Spacer()
                    CharacterFilterView(selectedStatus: $viewModel.selectedStatus)
                    if viewModel.isLoading && viewModel.characters.isEmpty {
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        List {
                            ForEach(viewModel.characters) { character in
                                CharacterCardView(character: character, backgroundStyle: viewModel.backgroundStyle(for: viewModel.characters.firstIndex(of: character) ?? 0))
                                    .onTapGesture {
                                        navigationPath.append(character)
                                    }
                                    .listRowInsets(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                    .listRowSeparator(.hidden)
                                    .listRowBackground(Color.clear)
                                    .onAppear {
                                        viewModel.loadMoreIfNeeded(currentItem: character)
                                    }
                            }
                            if viewModel.canLoadMorePages {
                                ProgressView()
                                    .frame(maxWidth: .infinity)
                                    .listRowBackground(Color.clear)
                                    .onAppear {
                                        if let lastCharacter = viewModel.characters.last {
                                            viewModel.loadMoreIfNeeded(currentItem: lastCharacter)
                                        }
                                    }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
            }
            .navigationTitle("Characters")
            .navigationDestination(for: CharacterModel.self) { character in
                CharacterDetailsViewRepresentable(character: character)
                    .ignoresSafeArea(.container, edges: .top)
                    .navigationBarBackButtonHidden(true)
            }
        }
        .onAppear {
            if viewModel.characters.isEmpty {
                viewModel.loadCharacters()
            }
        }
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(title: Text("Error"), message: Text(errorMessage.message), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    CharacterListView(viewModel: CharacterListViewModel(serviceDI: ServiceDIContainer.shared))
}
