//
//  BDateFormatter.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 22.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import Foundation

class BDateFormatter: DateFormatter {
    
    convenience init(type: DateFormatType, timeZone: TimeZoneType = .local) {
        self.init()
        
        calendar = Calendar(identifier: .iso8601)
        locale = Locale(identifier: "en_US")
        self.timeZone = timeZone.value
        dateFormat = type.format
    }
    
}

// MARK: - Public methods
extension BDateFormatter {
    
    func string(fromDate date: Date?) -> String? {
        
        guard let date = date else { return nil }
        return string(from: date)
    }
    
}
