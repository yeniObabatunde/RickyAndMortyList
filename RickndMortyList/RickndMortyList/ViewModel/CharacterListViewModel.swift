//
//  CharacterListViewModel.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 11/02/2025.
//

import SwiftUI
import Combine

struct ErrorMessage: Identifiable {
    let id = UUID()
    var message: String
}

final class CharacterListViewModel: CharacterListViewModelProtocol {
    
    @Published var characters: [CharacterModel] = []
    @Published var selectedStatus: CharacterStatus? = .alive {
            didSet {
                if oldValue != selectedStatus {
                    refreshCharacters()
                }
            }
        }
    @Published var isLoading = false
    @Published var error: Error?
    @Published var errorMessage: ErrorMessage?
    private var cancellables = Set<AnyCancellable>()
    private let serviceDI: ServiceDIContainerProtocol
  
    private var currentPage = 1
    var canLoadMorePages = true
    
    init(serviceDI: ServiceDIContainerProtocol) {
        self.serviceDI = serviceDI
    }
    
    func loadCharacters() {
        guard !isLoading && canLoadMorePages else {
            return
        }
        
        isLoading = true
        error = nil
        
        serviceDI.characterService.fetchCharacters(status: selectedStatus ?? .alive, page: currentPage)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }

                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isLoading = false
                    self.error = error
                    self.errorMessage = ErrorMessage(message: error.localizedDescription)
                }
            } receiveValue: { [weak self] newCharacters in
                guard let self = self else { return }
                let newResults = newCharacters.results ?? []
                self.characters.append(contentsOf: newResults)
                self.currentPage = (self.currentPage == newCharacters.info?.pages) ? 1 : self.currentPage + 1
                self.canLoadMorePages = !newResults.isEmpty
            }
            .store(in: &cancellables)
    }
    
    private func refreshCharacters() {
           characters = []
           currentPage = 1
           canLoadMorePages = true
            isLoading = false
           loadCharacters()
       }
       
    
    func filterCharacters(by status: CharacterStatus) {
        guard selectedStatus != status else { return }
        
        characters = []
        currentPage = 1
        canLoadMorePages = true
        selectedStatus = status
    }
    
    func loadMoreIfNeeded(currentItem: CharacterModel?) {
        canLoadMorePages = (characters.last == currentItem) ? true : false
        isLoading = (characters.last == currentItem) ? false : isLoading
        
        guard
            !isLoading,
            canLoadMorePages else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            self?.canLoadMorePages = true
            self?.loadCharacters()
        })
    }
    
    func backgroundStyle(for index: Int) -> CardBackgroundStyle {
           switch index % 6 {
           case 0: return .white
           case 1: return .blue
           case 2: return .pink
           case 3: return .white
           case 4: return .blue
           case 5: return .white
           default: return .white
           }
       }

}

 let mockCharacters: [CharacterModel] = [
       CharacterModel(
           id: 1,
           name: "Zephyr",
           species: "Elf",
           status: .alive,
           gender: "",
           image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
           location: .init(name: "Earth", url: "")
       ),
       CharacterModel(
           id: 2,
           name: "Aurora",
           species: "Human",
           status: .alive,
           gender: "",
           image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
           location: .init(name: "Earth", url: "")
           )
   ]

