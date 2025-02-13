//
//  CharacterDetailsViewRepresentable.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import SwiftUI

struct CharacterDetailsViewRepresentable: UIViewControllerRepresentable {
    let character: CharacterModel
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> CharacterDetailsViewController {
        let viewController = CharacterDetailsViewController(character: character) {
            presentationMode.wrappedValue.dismiss()
        }
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: CharacterDetailsViewController, context: Context) {
        uiViewController.view.frame = UIScreen.main.bounds
    }
}
