//
//  BJSONEncoder.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 22.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import Foundation

class BJSONEncoder: JSONEncoder {
    
    override init() {
        super.init()
        
        dateEncodingStrategy = .formatted(WDateFormatter(type: .yearMonthDay))
    }
    
    convenience init(dateFormatType: DateFormatType) {
        self.init()
        
        dateEncodingStrategy = .formatted(WDateFormatter(type: dateFormatType))
    }
    
}
