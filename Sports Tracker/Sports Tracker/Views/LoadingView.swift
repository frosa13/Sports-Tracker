//
//  LoadingView.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import UIKit

class LoadingView: UIView {
    
    private let activityIndicatorView = UIActivityIndicatorView(style: .large)
    
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
        layer.cornerRadius = Radius.r8.rawValue
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray238.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = Radius.r8.rawValue
        
        activityIndicatorView.color = .white
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicatorView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    func stopLoading() {
        activityIndicatorView.stopAnimating()
    }
}
