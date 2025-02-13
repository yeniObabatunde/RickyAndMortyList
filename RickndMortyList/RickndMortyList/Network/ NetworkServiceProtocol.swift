//
//   NetworkServiceProtocol.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {

    func request<T: Decodable>(
        type: T.Type,
        endpoint: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]?,
        body: Data?,
        headers: [String: String]?
    ) -> AnyPublisher<T, NetworkError>
}
