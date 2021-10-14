//
//  BJSONDecoder.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 22.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import Foundation

class BJSONDecoder: JSONDecoder {
    
    override init() {
        super.init()
        
        dateDecodingStrategy = .formatted(BDateFormatter(type: .yearMonthDay))
    }
    
    convenience init(dateFormatType: DateFormatType) {
        self.init()
        
        dateDecodingStrategy = .formatted(BDateFormatter(type: dateFormatType))
    }
    
}
