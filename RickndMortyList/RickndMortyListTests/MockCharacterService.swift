//
//  Test.swift
//  RickndMortyListTests
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import Combine
@testable import RickndMortyList
import SwiftUI

final class MockCharacterService: CharacterServiceProtocol {
    
    var mockResult: Result<CharacterModelWrapper, NetworkError>?
    
    func fetchCharacters(page: Int) -> AnyPublisher<CharacterModelWrapper, NetworkError> {
        return fetchMockedData()
    }
    
    func fetchCharacters(status: CharacterStatus, page: Int) -> AnyPublisher<CharacterModelWrapper, NetworkError> {
        return fetchMockedData()
    }
    
    private func fetchMockedData() -> AnyPublisher<CharacterModelWrapper, NetworkError> {
        if let result = mockResult {
            return result.publisher.eraseToAnyPublisher()
        } else {
            return Fail(error: NetworkError.noData).eraseToAnyPublisher()
        }
    }
}

final class ServiceDIContainerMock: ServiceDIContainerProtocol {
    let characterService: CharacterServiceProtocol
    
    init(characterService: CharacterServiceProtocol) {
        self.characterService = characterService
    }
}
