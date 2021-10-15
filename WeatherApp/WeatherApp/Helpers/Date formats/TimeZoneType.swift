//
//  TimeZoneType.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 22.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import Foundation

enum TimeZoneType {
    
    case local
    case utc(secondsFromGMT: Int)
    
    var value: TimeZone {
        
        switch self {
        case .local: return TimeZone.current
        case .utc(let seconds):
            
            guard let timeZone = TimeZone(secondsFromGMT: seconds) else {
                
                fatalError("Can not create time zone with such seconds from GMT \(seconds)")
            }
            return timeZone
        }
    }
    
}
