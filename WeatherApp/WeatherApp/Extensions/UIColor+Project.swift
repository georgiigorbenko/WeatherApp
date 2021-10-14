//
//  UIColor+Project.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 16.06.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        
        return UIColor(red: CGFloat.random(in: 0...1),
                       green: CGFloat.random(in: 0...1),
                       blue: CGFloat.random(in: 0...1),
                       alpha: 1)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    func image(size: CGSize, cornerRadius: CGFloat = 0) -> UIImage {
        
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            
            self.setFill()
            let rect = CGRect(origin: .zero, size: size)
            let clippingPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
            clippingPath.addClip()
            rendererContext.fill(rect)
        }
    }
    
    func with(alpha: CGFloat) -> UIColor {
        
        return withAlphaComponent(alpha)
    }
    
}

