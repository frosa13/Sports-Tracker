//
//  ErrorView.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didPressTryAgainButton()
}

class ErrorView: UIView {
    
    private let textContainerView = UIView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel(weight: .bold, size: 24, color: .white, alignment: .center)
    private let descriptionLabel = UILabel(weight: .regular, size: 16, color: .white, alignment: .center)
    private let tryAgainButton = UIButton()
    
    weak var delegate: ErrorViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        textContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(textContainerView)
        
        imageView.image = UIImage(named: ImageName.noConnection)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textContainerView.addSubview(imageView)
        
        titleLabel.text = Text.sportsDashboardErrorTitle.rawValue
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textContainerView.addSubview(titleLabel)
        
        descriptionLabel.text = Text.sportsDashboardErrorDescription.rawValue
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        textContainerView.addSubview(descriptionLabel)
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.title = Text.sportsDashboardErrorTryAgainButton.rawValue
        buttonConfiguration.baseForegroundColor = .black
        buttonConfiguration.background.backgroundColor = .gray238
        buttonConfiguration.background.cornerRadius = .infinity
        tryAgainButton.configuration = buttonConfiguration
        tryAgainButton.addTarget(self, action: #selector(tryAgainButtonPressed), for: .touchUpInside)
        tryAgainButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tryAgainButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            textContainerView.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor),
            textContainerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margin.m16.rawValue),
            textContainerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margin.m16.rawValue),
            textContainerView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textContainerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textContainerView.bottomAnchor.constraint(lessThanOrEqualTo: tryAgainButton.topAnchor, constant: -Margin.m32.rawValue),
            
            imageView.topAnchor.constraint(equalTo: textContainerView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: textContainerView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: Size.s100.rawValue),
            imageView.widthAnchor.constraint(equalToConstant: Size.s100.rawValue),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Margin.m32.rawValue),
            titleLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Margin.m8.rawValue),
            descriptionLabel.leadingAnchor.constraint(equalTo: textContainerView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: textContainerView.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: textContainerView.bottomAnchor),
            
            tryAgainButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margin.m32.rawValue),
            tryAgainButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margin.m32.rawValue),
            tryAgainButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Margin.m32.rawValue),
            tryAgainButton.heightAnchor.constraint(equalToConstant: Size.s44.rawValue)
        ])
    }
    
    @objc
    private func tryAgainButtonPressed() {
        delegate?.didPressTryAgainButton()
    }
}
