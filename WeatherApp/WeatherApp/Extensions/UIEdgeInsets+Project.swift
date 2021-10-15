//
//  UIEdgeInsets.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import UIKit

extension UIEdgeInsets {
    
    init(offset: CGFloat) {
        self.init(top: offset, left: offset, bottom: offset, right: offset)
    }
    
    func new(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) -> Self {
        
        return UIEdgeInsets(top: top ?? self.top,
                            left: left ?? self.left,
                            bottom: bottom ?? self.bottom,
                            right: right ?? self.right)
    }
    
}
