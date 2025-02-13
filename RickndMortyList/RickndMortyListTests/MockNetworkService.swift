//
//  MockNetworkService.swift
//  RickndMortyListTests
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import XCTest
import Combine
@testable import RickndMortyList

class MockNetworkService: NetworkServiceProtocol {
    
    var mockResult: Result<Data, NetworkError>?

    func request<T: Decodable>(
        type: T.Type,
        endpoint: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]?,
        body: Data?,
        headers: [String: String]?
    ) -> AnyPublisher<T, NetworkError> {
        
        guard let result = mockResult else {
            return Fail(error: NetworkError.unknown(NSError(domain: "MockNetworkService", code: -1, userInfo: nil)))
                .eraseToAnyPublisher()
        }
        
        return Future<T, NetworkError> { promise in
            switch result {
            case .success(let data):
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    promise(.success(decodedObject))
                } catch {
                    promise(.failure(NetworkError.decodingError))
                }
            case .failure(let error):
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
