//
//  DesignColor.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 18.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

extension Design {
    
    enum Color: String {
        
        case navigationBarTitle = "navigationBarTitle"
        case navigationBar = "co_navigationBar"
        case navigationBarTint = "navigationBarTint"
        
        case white = "white"
        case black = "black"
        case darkGray = "darkGray"
        case success = "co_success"
        case background = "co_background"
        case label = "co_label"
        
        func callAsFunction() -> UIColor {
            
            switch self {
            case .white:
                return .white
            case .darkGray:
                return .darkGray
            case .navigationBarTitle:
                return .white
            case .navigationBarTint:
                return .white
            case .black:
                return .black
            default:
                return UIColor(named: rawValue) ?? .black
            }
        }
        
    }
    
}
