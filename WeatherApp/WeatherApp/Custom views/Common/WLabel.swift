//
//  WLabel.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 21.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

class WLabel: UILabel {
    
    // MARK: - Public properties
    
    var textInsets = UIEdgeInsets.zero {
        
        didSet { invalidateIntrinsicContentSize() }
    }
    
    // MARK: - Lifecycle
    
    convenience init(font: Design.Font? = nil, textColor: Design.Color? = nil, text: String? = nil) {
        self.init()
        
        self.font = font?()
        self.textColor = textColor?()
        self.text = text
    }
    
    override var intrinsicContentSize: CGSize {
        
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + textInsets.left + textInsets.right,
                      height: size.height + textInsets.top + textInsets.bottom)
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
    }

}
