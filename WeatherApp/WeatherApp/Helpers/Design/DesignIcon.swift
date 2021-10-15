//
//  DesignIcon.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 18.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

extension Design {
    
    enum Icon: String {
        
        case sunMax = "sun.max"
        case sunHaze = "sun.haze"
        case cloudMoonBoltFill = "cloud.moon.bolt.fill"
        case cloudRain = "cloud.rain"
        case cloudSnow = "cloud.snow"
        case cloudBoltRainFill = "cloud.bolt.rain.fill"
        case cloudFill = "cloud.fill"
        case humidity = "humidity"
        case drop = "drop"
        case thermometer = "thermometer"
        case arrowshapeTurnUpForward = "arrowshape.turn.up.forward"
        case safari = "safari"
        case locationFill = "location.fill"
        
        func callAsFunction(config: UIImage.SymbolConfiguration? = nil) -> UIImage {
            
            return UIImage(named: rawValue, in: nil, with: config)
                ?? UIImage(systemName: rawValue, withConfiguration: config)
                ?? UIImage()
        }
    }
    
}
