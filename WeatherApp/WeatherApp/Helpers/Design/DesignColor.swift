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
        case link = "link"
        case red = "red"
        case yellow = "yellow"
        case dash = "dash"
        case orange = "orange"
        case separator = "separator"
        case green = "green"
        
        func callAsFunction() -> UIColor {
            
            switch self {
            case .white:
                return .white
            case .darkGray:
                return .darkGray
            case .navigationBarTitle:
                return .black
            case .navigationBarTint:
                return .white
            case .black:
                return .black
            case .link:
                return .link
            case .red:
                return .red
            case .yellow:
                return .yellow
            case .dash:
                return .lightGray
            case .orange:
                return .orange
            case .separator:
                return .lightGray
            case .green:
                return .green
            default:
                return UIColor(named: rawValue) ?? .black
            }
        }
        
    }
    
}
