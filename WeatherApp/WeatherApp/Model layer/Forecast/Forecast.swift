//
//  Forecast.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import Foundation

protocol Forecast: APIResponse {
    
    var list: [Weather] { get }
    var city: City { get }
}

struct ForecastProducer: Forecast {
    
    var list: [Weather]
    var city: City
    
    private enum CodingKeys: String, CodingKey {
        
        case list = "list"
        case city = "city"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        list = try container.decode(ArrayDecodable<WeatherProducer>.self, key: .list).elements
        city = try container.decode(CityProducer.self, key: .city)
    }
    
}
