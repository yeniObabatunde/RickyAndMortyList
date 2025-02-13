//
//  CharacterListViewModelProtocol.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 12/02/2025.
//

import Foundation
import Combine

protocol CharacterListViewModelProtocol: ObservableObject {
    var characters: [CharacterModel] { get }
    var selectedStatus: CharacterStatus? { get set }
    var isLoading: Bool { get }
    var error: Error? { get }
    
    func loadCharacters()
    func filterCharacters(by status: CharacterStatus)
    func loadMoreIfNeeded(currentItem: CharacterModel?)
}

protocol CharacterServiceProtocol {
    func fetchCharacters(page: Int) -> AnyPublisher<CharacterModelWrapper, NetworkError>
    func fetchCharacters(status: CharacterStatus, page: Int) -> AnyPublisher<CharacterModelWrapper, NetworkError>
}

