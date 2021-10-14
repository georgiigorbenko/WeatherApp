//
//  UIView+Project.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 18.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

extension UIView {
    
    func forceLayout() {
        
        setNeedsLayout()
        layoutIfNeeded()
    }
    
    func snapshot() -> UIImage? {
        
        return UIGraphicsImageRenderer(bounds: bounds).image { context in
            
            layer.render(in: context.cgContext)
        }
    }
    
    func firstSubview<T: UIView>(of type: T.Type) -> T? {
        
        for view in subviews {
            
            if let view = view as? T {
                
                return view
            }
            else if let view = view.firstSubview(of: T.self) {
                
                return view
            }
        }
        return nil
    }
    
}
