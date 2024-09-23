//
//  SportsTableViewHeaderView.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 22/09/2024.
//

import UIKit

protocol SportsTableViewHeaderViewDelegate: AnyObject {
    func didTapHeaderView(isSelected: Bool, id: UUID?)
}

class SportsTableViewHeaderView: UIView {
    
    private let containerView = UIView()
    private let sportIconImageView = UIImageView()
    private let sportNameLabel = UILabel(weight: .bold, size: 24, color: .white)
    private let accessoryImageView = UIImageView()
    
    private var id: UUID?
    
    private var isSelected = true {
        didSet {
            accessoryImageView.image = UIImage(named: isSelected ? ImageName.arrowUp : ImageName.arrowDown)
        }
    }
    
    weak var delegate: SportsTableViewHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .teal
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGestureRecognizer)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        
        sportIconImageView.contentMode = .scaleAspectFit
        sportIconImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sportIconImageView)
        
        sportNameLabel.numberOfLines = 0
        sportNameLabel.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sportNameLabel)
        
        accessoryImageView.image = UIImage(named: ImageName.arrowUp)
        accessoryImageView.contentMode = .scaleAspectFit
        accessoryImageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(accessoryImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: Margin.m8.rawValue),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Margin.m8.rawValue),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Margin.m8.rawValue),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -Margin.m8.rawValue),
            
            sportIconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            sportIconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            sportIconImageView.heightAnchor.constraint(equalToConstant: Size.s24.rawValue),
            sportIconImageView.widthAnchor.constraint(equalToConstant: Size.s24.rawValue),
            
            sportNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            sportNameLabel.leadingAnchor.constraint(equalTo: sportIconImageView.trailingAnchor, constant: Margin.m4.rawValue),
            sportNameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            accessoryImageView.leadingAnchor.constraint(greaterThanOrEqualTo: sportNameLabel.trailingAnchor, constant: Margin.m4.rawValue),
            accessoryImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            accessoryImageView.heightAnchor.constraint(equalToConstant: Size.s12.rawValue),
            accessoryImageView.widthAnchor.constraint(equalToConstant: Size.s12.rawValue),
            accessoryImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
    
    func configure(sectionViewModel: SportsTableViewSectionViewModel) {
        self.id = sectionViewModel.id
        sportIconImageView.image = UIImage(named: sectionViewModel.sportImageName)
        sportNameLabel.text = sectionViewModel.title
        self.isSelected = sectionViewModel.isCollapsed == false
    }
    
    @objc
    private func didTapView() {
        delegate?.didTapHeaderView(isSelected: isSelected, id: self.id)
        isSelected.toggle()
    }
}
