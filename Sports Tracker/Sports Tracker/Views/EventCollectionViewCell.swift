//
//  EventCollectionViewCell.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 22/09/2024.
//

import UIKit

protocol EventCollectionViewCellDelegate: NSObjectProtocol {
    func favoriteButtonTapped(favorite: Bool, id: UUID?)
}

class EventCollectionViewCell: UICollectionViewCell {
    
    class var cellIdentifier: String { return String(describing: EventCollectionViewCell.self) }
    
    private let countdownLabelContainerView = UIView()
    private let countdownLabel = CountdownLabel(weight: .regular, size: 16, color: .white, alignment: .center)
    private var favoriteButton = UIButton()
    private var participant1Label = UILabel(weight: .regular, size: 16, color: .white, alignment: .center)
    private var participant2Label = UILabel(weight: .regular, size: 16, color: .white, alignment: .center)
    
    weak var delegate: EventCollectionViewCellDelegate?
    
    private var id: UUID?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        countdownLabelContainerView.layer.borderWidth = 1
        countdownLabelContainerView.layer.borderColor = UIColor.white.cgColor
        countdownLabelContainerView.layer.cornerRadius = Radius.r4.rawValue
        countdownLabelContainerView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(countdownLabelContainerView)
        
        countdownLabel.numberOfLines = 1
        countdownLabel.text = "Loading..."
        countdownLabel.translatesAutoresizingMaskIntoConstraints = false
        countdownLabelContainerView.addSubview(countdownLabel)
        
        favoriteButton.setImage(UIImage(named: ImageName.star), for: .normal)
        favoriteButton.setImage(UIImage(named: ImageName.starFill), for: .selected)
        favoriteButton.imageView?.contentMode = .scaleAspectFit
        favoriteButton.addTarget(self, action: #selector(favoriteButtonPressed), for: .touchUpInside)
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(favoriteButton)
        
        participant1Label.numberOfLines = 1
        participant1Label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(participant1Label)
        
        participant2Label.numberOfLines = 1
        participant2Label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(participant2Label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            countdownLabelContainerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Margin.m16.rawValue),
            countdownLabelContainerView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            countdownLabelContainerView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            countdownLabelContainerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            countdownLabel.topAnchor.constraint(equalTo: countdownLabelContainerView.topAnchor, constant: Margin.m4.rawValue),
            countdownLabel.leadingAnchor.constraint(equalTo: countdownLabelContainerView.leadingAnchor, constant: Margin.m4.rawValue),
            countdownLabel.trailingAnchor.constraint(equalTo: countdownLabelContainerView.trailingAnchor, constant: -Margin.m4.rawValue),
            countdownLabel.bottomAnchor.constraint(equalTo: countdownLabelContainerView.bottomAnchor, constant: -Margin.m4.rawValue),
            
            favoriteButton.topAnchor.constraint(equalTo: countdownLabelContainerView.bottomAnchor, constant: Margin.m4.rawValue),
            favoriteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: Size.s24.rawValue),
            favoriteButton.heightAnchor.constraint(equalToConstant: Size.s24.rawValue),
            
            participant1Label.topAnchor.constraint(equalTo: favoriteButton.bottomAnchor, constant: Margin.m4.rawValue),
            participant1Label.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            participant1Label.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            participant1Label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            participant2Label.topAnchor.constraint(equalTo: participant1Label.bottomAnchor),
            participant2Label.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            participant2Label.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            participant2Label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            participant2Label.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: Margin.m16.rawValue)
        ])
    }
    
    @objc
    private func favoriteButtonPressed() {
        favoriteButton.isSelected.toggle()
        delegate?.favoriteButtonTapped(favorite: favoriteButton.isSelected, id: self.id)
    }
    
    func configure(cellViewModel: EventCellViewModel) {
        countdownLabel.targetDate = cellViewModel.targetDate
        favoriteButton.isSelected = cellViewModel.isFavorite
        participant1Label.text = cellViewModel.participant1
        participant2Label.text = cellViewModel.participant2
        self.id = cellViewModel.id
    }
    
    override func prepareForReuse() {
        countdownLabel.invalidateTimer()
        countdownLabel.text = "Loading..."
        favoriteButton.isSelected = false
        participant1Label.text = ""
        participant2Label.text = ""
    }
}
