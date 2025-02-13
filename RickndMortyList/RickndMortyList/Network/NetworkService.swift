//
//  NetworkService.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceProtocol {
  
    private let baseURL: String
    private let session: URLSession
    
    init(baseURL: String, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    func request<T: Decodable>(
        type: T.Type,
        endpoint: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil,
        headers: [String: String]? = nil
    ) -> AnyPublisher<T, NetworkError> {
        let urlString = baseURL + endpoint
        guard var urlComponents = URLComponents(string: urlString) else {
            print("Invalid URL: \(endpoint)")
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            print("Invalid URL components: \(urlString)")
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        Logger.printIfDebug(data: "BASE URL: \(url)", logType: .info)
        var request = URLRequest(url: url, timeoutInterval: 10)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                Logger.printIfDebug(data: "Network failure: \(error.localizedDescription)", logType: .error)
                return NetworkError.unknown(error)
            }
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    Logger.printIfDebug(data: "Invalid response: \(response)", logType: .error)
                    throw NetworkError.noData
                }
                if !(200...299).contains(httpResponse.statusCode) {
                    Logger.printIfDebug(data: "Server error: \(httpResponse.statusCode)", logType: .error)
                    throw NetworkError.serverError(httpResponse.statusCode)
                }
                if let jsonString = String(data: data, encoding: .utf8) {
                    Logger.printIfDebug(data: "Received JSON: \(jsonString)", logType: .success)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                Logger.printIfDebug(data: "Decoding error: \(error.localizedDescription)", logType: .error)
                return NetworkError.decodingError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

}
