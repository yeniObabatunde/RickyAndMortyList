//
//  ServiceDIContainer.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import Foundation
import Combine

protocol ServiceDIContainerProtocol {
    var characterService: CharacterServiceProtocol { get }
}

final class ServiceDIContainer: ServiceDIContainerProtocol {
    static let shared = ServiceDIContainer()
    
    lazy var characterService: CharacterServiceProtocol = {
        let networkService = NetworkService(baseURL: AppConstants.Api.baseUrlString)
        return CharacterService(networkService: networkService)
    }()
    
    private init() {}
}


final class CharacterService: CharacterServiceProtocol {
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchCharacters(page: Int) -> AnyPublisher<CharacterModelWrapper, NetworkError> {
        let queryItems = [URLQueryItem(name: "page", value: String(page))]
        return networkService.request(
            type: CharacterModelWrapper.self, endpoint: AppConstants.Api.character,
            method: .get,
            queryItems: queryItems,
            body: nil,
            headers: nil
        )
    }
    
    func fetchCharacters(status: CharacterStatus, page: Int) -> AnyPublisher<CharacterModelWrapper, NetworkError> {
        let queryItems = [
            URLQueryItem(name: "status", value: status.rawValue),
            URLQueryItem(name: "page", value: String(page))
        ]
        return networkService.request(
            type: CharacterModelWrapper.self, endpoint: AppConstants.Api.character,
            method: .get,
            queryItems: queryItems,
            body: nil,
            headers: nil
        )
    }
}
