//
//  ForecastSectionData.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import Foundation

protocol ForecastSectionData {
    
    var header: ForecastHeaderData { get }
    var date: Date { get }
    var cells: [ForecastCellBox] { get }
}

struct ForecastSectionDataProducer: ForecastSectionData {
    
    var header: ForecastHeaderData
    var date: Date
    var cells: [ForecastCellBox]
}

struct ForecastSectionBox: Hashable {
    
    var value: ForecastSectionData
    
    init(_ value: ForecastSectionData) {
        
        self.value = value
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(value.date)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        
        return lhs.value.header.name == rhs.value.header.name
            && lhs.value.date == rhs.value.date
    }
    
}
