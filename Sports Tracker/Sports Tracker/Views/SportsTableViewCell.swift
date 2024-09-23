//
//  SportsTableViewCell.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 22/09/2024.
//

import UIKit

class SportsTableViewCell: UITableViewCell {
    
    private enum Constants {
        static let eventsCollectionViewHeight: CGFloat = 126
        static let eventsCollectionViewCellWidth: CGFloat = 90
    }
    
    class var cellIdentifier: String { return String(describing: SportsTableViewCell.self) }
    
    private var eventsCollectionView: UICollectionView!
    
    private var eventCellViewModels: [EventCellViewModel]?
    
    weak var eventCollectionViewCellDelegate: EventCollectionViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        self.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(
            width: Constants.eventsCollectionViewCellWidth,
            height: Constants.eventsCollectionViewHeight
        )
        layout.minimumLineSpacing = Margin.m8.rawValue
        
        eventsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        eventsCollectionView.dataSource = self
        eventsCollectionView.register(
            EventCollectionViewCell.self,
            forCellWithReuseIdentifier: EventCollectionViewCell.cellIdentifier
        )
        eventsCollectionView.backgroundColor = .clear
        eventsCollectionView.allowsMultipleSelection = false
        eventsCollectionView.showsHorizontalScrollIndicator = false
        eventsCollectionView.showsVerticalScrollIndicator = false
        eventsCollectionView.isPagingEnabled = false
        eventsCollectionView.decelerationRate = .fast
        eventsCollectionView.clipsToBounds = false
        eventsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(eventsCollectionView)
    }
    
    private func setupConstraints() {
        let heightConstraint = eventsCollectionView.heightAnchor.constraint(equalToConstant: Constants.eventsCollectionViewHeight)
        heightConstraint.priority = .defaultHigh
        
        NSLayoutConstraint.activate([
            eventsCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventsCollectionView.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor),
            eventsCollectionView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor),
            eventsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            heightConstraint,
            eventsCollectionView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    func configure(eventCellViewModels: [EventCellViewModel]) {
        self.eventCellViewModels = eventCellViewModels
        self.eventsCollectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension SportsTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.eventCellViewModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let eventCellViewModel = self.eventCellViewModels?[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: EventCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? EventCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(cellViewModel: eventCellViewModel)
        cell.delegate = self.eventCollectionViewCellDelegate
        return cell
    }
}
