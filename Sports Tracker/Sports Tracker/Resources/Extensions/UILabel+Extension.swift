//
//  UILabel+Extension.swift
//  Sports Tracker
//
//  Created by Francisco Rosa on 21/09/2024.
//

import UIKit

extension UILabel {
    convenience init(
        weight: UIFont.Weight,
        size: CGFloat,
        color: UIColor? = nil,
        alignment: NSTextAlignment? = nil
    ) {
        self.init()
        
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        
        if let color = color { self.textColor = color }
        if let alignment = alignment { self.textAlignment = alignment }
    }
}
