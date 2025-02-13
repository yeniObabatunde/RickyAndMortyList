//
//  CharacterModel.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 12/02/2025.
//

import Foundation

struct CharacterModelWrapper: Codable {
    let info: Info?
    let results: [CharacterModel]?
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

struct CharacterModel: Identifiable, Equatable, Codable, Hashable {
    let id: Int?
    let name: String?
    let species: String?
    let status: CharacterStatus?
    let gender: String?
    let image: String?
    var imageURL: URL? {
        URL(string: image ?? "")
    }
    let location: LocationModel?
    
    struct LocationModel: Equatable, Codable, Hashable {
        let name: String?
        let url: String?
    }
}

enum CharacterStatus: String, CaseIterable, Codable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Hashable {
    case female = "Female"
    case genderless = "Genderless"
    case male = "Male"
    case unknown = "unknown"
}
