//
//  ForecastCellData.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import Foundation

protocol ForecastCellData {
    
    var weatherStateType: WeatherStateType { get }
    var date: Date { get }
    var detail: String? { get }
    var temperature: Double { get }
}

struct ForecastCellDataProducer: ForecastCellData {
    
    var weatherStateType: WeatherStateType
    var date: Date
    var detail: String?
    var temperature: Double
}

struct ForecastCellBox: Hashable {
    
    var value: ForecastCellData
    
    init(_ value: ForecastCellData) {
        
        self.value = value
    }
    
    func hash(into hasher: inout Hasher) {
        
        hasher.combine(value.date)
    }
    
    static func ==(lhs: Self, rhs: Self) -> Bool {
        
        return lhs.value.date == rhs.value.date
            && lhs.value.temperature == rhs.value.temperature
            && lhs.value.detail == rhs.value.detail
            && lhs.value.weatherStateType == rhs.value.weatherStateType
    }
    
}
