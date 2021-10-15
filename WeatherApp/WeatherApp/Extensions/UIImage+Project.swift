//
//  UIImage+Project.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import UIKit

extension UIImage {
    
    static func gradientImage(size: CGSize, colors: [UIColor]) -> UIImage? {
        
        let cgcolors = colors.map { $0.cgColor }

        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        defer { UIGraphicsEndImageContext() }

        let step: CGFloat = 1.0 / CGFloat(colors.count - 1)
        var locations: [CGFloat] = (0...colors.count - 1).map { min(CGFloat($0) * step, 1) }
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: cgcolors as NSArray as CFArray,
                                        locations: &locations) else { return nil }

        context.drawLinearGradient(gradient,
                                   start: CGPoint(x: 0.0, y: 0.0),
                                   end: CGPoint(x: size.width, y: 0.0),
                                   options: [])

        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
