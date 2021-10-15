//
//  ForecastHeaderData.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import Foundation

protocol ForecastHeaderData {
    
    var name: String { get }
}

struct ForecastHeaderDataProducer: ForecastHeaderData {
    
    var name: String
}
