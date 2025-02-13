//
//  CharacterDetailsViewController.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import UIKit

final class CharacterDetailsViewController: UIViewController {
    
    private let characterView = CharacterDetailsView()
    private let character: CharacterModel
    private let onDismiss: (() -> Void)?
    
    init(character: CharacterModel, onDismiss: (() -> Void)? = nil) {
        self.character = character
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = characterView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        characterView.configure(with: character)
        loadCachedImage(from: character.imageURL)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        if let window = view.window {
            view.frame = window.bounds
        }
    }
    
    private func setupViewController() {
        characterView.onBackButtonTapped = { [weak self] in
            self?.onDismiss?()
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
    private func loadCachedImage(from url: URL?) {
        guard let url = url else { return }
        characterView.imageLoadingIndicator.startAnimating()
        Task {
            do {
                let image = try await ImageLoadingService.shared.loadImage(from: url)
                await MainActor.run {
                    UIView.transition(with: characterView.imageView,
                                      duration: 0.3,
                                      options: .transitionCrossDissolve) { [weak self] in
                        self?.characterView.imageView.image = image
                        self?.characterView.imageLoadingIndicator.stopAnimating()
                    }
                }
            } catch {
                
                await MainActor.run {
                    self.characterView.imageView.image = UIImage(named: "defaultImage")
                    self.characterView.imageLoadingIndicator.stopAnimating()
                }
            }
        }
    }
}
