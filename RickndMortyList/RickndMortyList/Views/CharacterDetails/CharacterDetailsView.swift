//
//  CharacterDetailsView.swift
//  RickndMortyList
//
//  Created by Sharon Omoyeni Babatunde on 13/02/2025.
//

import UIKit

final class CharacterDetailsView: UIView {
    
    var onBackButtonTapped: (() -> Void)?
    
    lazy var imageLoadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.clipsToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
         imageView.contentMode = .scaleAspectFill
         imageView.layer.cornerRadius = 30
         imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .black
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var speciesAndGenderLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var statusButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.layer.cornerRadius = 16
        button.isUserInteractionEnabled = false
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        imageView.addSubview(imageLoadingIndicator)
        addSubview(backButton)
        addSubview(nameLabel)
        addSubview(speciesAndGenderLabel)
        addSubview(statusButton)
        addSubview(locationLabel)
        
        setupConstraints()
        
        setupConstraints()
        setupActions()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            imageLoadingIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            imageLoadingIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            speciesAndGenderLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            speciesAndGenderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            speciesAndGenderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            statusButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 24),
            statusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            statusButton.heightAnchor.constraint(equalToConstant: 32),
            
            locationLabel.topAnchor.constraint(equalTo: speciesAndGenderLabel.bottomAnchor, constant: 25),
            locationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        onBackButtonTapped?()
    }

    func configure(with character: CharacterModel) {
        nameLabel.text = character.name
        speciesAndGenderLabel.text = "\(character.species ?? "") • \(character.gender?.capitalized ?? "")"
        locationLabel.text = "Location: \(character.location?.name ?? "")"
        
        statusButton.setTitle(character.status?.rawValue, for: .normal)
        switch character.status {
        case .alive:
            statusButton.backgroundColor = UIColor.systemGreen.withAlphaComponent(0.1)
            statusButton.setTitleColor(.systemGreen, for: .normal)
        case .dead:
            statusButton.backgroundColor = UIColor.systemRed.withAlphaComponent(0.1)
            statusButton.setTitleColor(.systemRed, for: .normal)
        case .unknown:
            statusButton.backgroundColor = UIColor.systemGray.withAlphaComponent(0.1)
            statusButton.setTitleColor(.systemGray, for: .normal)
        case .none:
            break;
        }
        
    }
    
    
}

