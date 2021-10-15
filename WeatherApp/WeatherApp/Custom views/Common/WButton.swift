//
//  WButton.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 21.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

class WButton: UIButton {
    
    // MARK: - Lifecycle
    
    convenience init(font: Design.Font? = nil,
                     titleColor: Design.Color? = nil,
                     image: Design.Icon? = nil,
                     backgrounColor: Design.Color? = nil,
                     tintColor: Design.Color? = nil,
                     title: String? = nil) {
        self.init()
        
        setFont(font, for: .normal)
        setImage(image, for: .normal)
        setTitleColor(titleColor, for: .normal)
        setTitle(title, for: .normal)
        self.backgroundColor = backgrounColor?()
        self.tintColor = tintColor?()
    }
    
}

// MARK: - Public methods
extension WButton {
    
    func setTitleColor(_ color: Design.Color?, for state: UIControl.State) {
        
        self.setTitleColor(color?(), for: state)
    }
    
    func setImage(_ image: Design.Icon?, for state: UIControl.State) {
        
        self.setImage(image?(), for: state)
    }
    
    func setFont(_ font: Design.Font?, for state: UIControl.State) {
        
        setFont(font?(), for: state)
    }
    
}

// MARK: - Private methods
private extension WButton {
    
    func setFont(_ font: UIFont?, for state: UIControl.State) {
        
        titleLabel?.font = font
    }
    
}
