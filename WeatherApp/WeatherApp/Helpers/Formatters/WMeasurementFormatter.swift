//
//  WMeasurementFormatter.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

class WMeasurementFormatter: MeasurementFormatter {
    
    override init() {
        super.init()
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
 
    private func setup() {
    
        unitStyle = .short
        unitOptions = .providedUnit
    }
    
}
