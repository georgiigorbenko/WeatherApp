//
//  WImageView.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 21.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

class WImageView: UIImageView {
    
    // MARK: - Lifecycle
    
    convenience init(image: Design.Icon, contentMode: UIControl.ContentMode) {
        self.init(image: image())
        
        self.contentMode = contentMode
    }
    
}
