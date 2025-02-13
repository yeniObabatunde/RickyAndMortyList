//
//  CharacterServiceTests.swift
//  RickndMortyListTests
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import XCTest
import Combine
@testable import RickndMortyList

final class CharacterServiceTests: XCTestCase {
    
    var mockNetworkService: MockNetworkService!
    var characterService: CharacterService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        characterService = CharacterService(networkService: mockNetworkService)
        cancellables = []
    }

    override func tearDown() {
        mockNetworkService = nil
        characterService = nil
        cancellables = nil
        super.tearDown()
    }

    func testToFetchCharactersShouldBeSuccessful() {
        let expectedCharacters = [
            CharacterModel(
                id: 1,
                name: "Rick",
                species: "Human",
                status: .alive,
                gender: "Male",
                image: "",
                location: .init(name: "Earth", url: "")
            )
        ]
        
        let mockResponse = CharacterModelWrapper(info: nil, results: expectedCharacters)
        
        let encodedData = try! JSONEncoder().encode(mockResponse)
        mockNetworkService.mockResult = .success(encodedData)

        let expectation = XCTestExpectation(description: "Successfully fetches characters")
        characterService.fetchCharacters(page: 1)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.results?.count, expectedCharacters.count)
                XCTAssertEqual(response.results?.first?.name, "Rick")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
    }

    func testToFetchCharactersShouldAsserFailure() {
        mockNetworkService.mockResult = .failure(.serverError(500))
        let expectation = XCTestExpectation(description: "Fails with server error")

        characterService.fetchCharacters(page: 1)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, .serverError(500))
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure but got success")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}


