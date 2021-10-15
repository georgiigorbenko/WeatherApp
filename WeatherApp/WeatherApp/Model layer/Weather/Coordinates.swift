//
//  Coordinates.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

protocol Coordinates: APIResponse {
    
    var lon: Double { get }
    var lat: Double { get }
}

struct CoordinatesProducer: Coordinates {
    
    var lon: Double
    var lat: Double
    
    private enum CodingKeys: String, CodingKey {
        
        case lon = "lon"
        case lat = "lat"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        lon = try container.decode(key: .lon)
        lat = try container.decode(key: .lat)
    }
    
}
