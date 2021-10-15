//
//  WStackView.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 21.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

class WStackView: UIStackView {
    
    convenience init(arrangedSubviews: [UIView] = [],
                     axis: NSLayoutConstraint.Axis = .vertical,
                     distribution: UIStackView.Distribution = .fill,
                     alignment: UIStackView.Alignment = .fill,
                     spacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    func addArrangedSubviews(_ views: [UIView]) {
        
        views.forEach { addArrangedSubview($0) }
    }
    
}
