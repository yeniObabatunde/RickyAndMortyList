//
//  CharacterModel.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 12/02/2025.
//

import Foundation

struct CharacterModelWrapper: Decodable {
    let info: Info?
    let results: [CharacterModel]?
}

// MARK: - Info
struct Info: Decodable {
    let count, pages: Int?
    let next: String?
    let prev: String?
}

struct CharacterModel: Identifiable, Equatable, Decodable, Hashable {
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
    
    struct LocationModel: Equatable, Decodable, Hashable {
        let name: String?
        let url: String?
    }
}

enum CharacterStatus: String, CaseIterable, Decodable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

enum CharacterGender: String, Decodable, Hashable {
    case female = "Female"
    case genderless = "Genderless"
    case male = "Male"
    case unknown = "unknown"
}
