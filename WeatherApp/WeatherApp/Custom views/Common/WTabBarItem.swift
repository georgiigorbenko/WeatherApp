//
//  WTabBarItem.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import UIKit

class WTabBarItem: UITabBarItem {
    
    // MARK: - Lifecycle

    convenience init(title: String? = nil, image: Design.Icon? = nil, selectedImage: Design.Icon? = nil) {
        self.init(title: title, image: image?(), selectedImage: selectedImage?())
        
    }
    
}
