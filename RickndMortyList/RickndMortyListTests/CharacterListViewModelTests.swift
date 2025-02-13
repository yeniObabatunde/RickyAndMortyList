//
//  CharacterListViewModelTests.swift
//  RickndMortyListTests
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import XCTest
import Combine
@testable import RickndMortyList
import SwiftUI


final class CharacterListViewModelTests: XCTestCase {
    
    private var viewModel: CharacterListViewModel!
    private var mockService: MockCharacterService!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockService = MockCharacterService()
        let mockDIContainer = ServiceDIContainerMock(characterService: mockService)
        viewModel = CharacterListViewModel(serviceDI: mockDIContainer)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testViewModelLoadCharactersShouldBeSuccessful() {
        let expectedCharacters = [ CharacterModel(
            id: 1,
            name: "Zephyr",
            species: "Elf",
            status: .alive,
            gender: "",
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            location: .init(name: "Earth", url: "")
        )]
        mockService.mockResult = .success(CharacterModelWrapper(info: nil, results: expectedCharacters))

        let expectation = XCTestExpectation(description: "Characters loaded successfully")
        viewModel.$characters
            .dropFirst()
            .sink { characters in
                XCTAssertEqual(characters.count, expectedCharacters.count)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadCharacters()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testViewModelLoadCharactersErrorMessageShouldAssertFailure() {
        mockService.mockResult = .failure(.serverError(500))

        let expectation = XCTestExpectation(description: "Error message should be set when character list fetch fails.")
        
        viewModel.$errorMessage
            .dropFirst()
            .sink { errorMessage in
                print("Received errorMessage: \(String(describing: errorMessage?.message))")
                XCTAssertNotNil(errorMessage)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        viewModel.loadCharacters()
        wait(for: [expectation], timeout: 1.0)
    }


    func testFilterCharactersByStatus() {
        let initialStatus = viewModel.selectedStatus
        let newStatus: CharacterStatus = .dead

        viewModel.filterCharacters(by: newStatus)

        XCTAssertEqual(viewModel.selectedStatus, newStatus)
        XCTAssertNotEqual(viewModel.selectedStatus, initialStatus)
        XCTAssertTrue(viewModel.characters.isEmpty)
    }
    
    func testViewModelLoadMoreIfNeeded() {
        let expectedCharacters = [CharacterModel(
            id: 2,
            name: "Aurora",
            species: "Human",
            status: .alive,
            gender: "Male",
            image: "https://rickandmortyapi.com/api.jpeg",
            location: .init(name: "Earth", url: "")
        )]
        
        mockService.mockResult = .success(CharacterModelWrapper(info: nil, results: expectedCharacters))
        
        let expectation = XCTestExpectation(description: "Characters should load before checking load more logic")
        viewModel.loadCharacters()
        viewModel.$characters
            .dropFirst()
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 1.0)
        
        viewModel.loadMoreIfNeeded(currentItem: expectedCharacters.last)
        XCTAssertTrue(viewModel.canLoadMorePages)
    }

}

