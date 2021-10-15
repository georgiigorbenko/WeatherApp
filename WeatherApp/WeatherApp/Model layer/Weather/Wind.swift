//
//  Wind.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

protocol Wind: APIResponse {
    
    var speed: Double { get }
    var degrees: Double { get }
    var gust: Double? { get }
}

struct WindProducer: Wind {
    
    var speed: Double
    var degrees: Double
    var gust: Double?
    
    private enum CodingKeys: String, CodingKey {
        
        case speed = "speed"
        case degrees = "deg"
        case gust = "gust"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        speed = try container.decode(key: .speed)
        degrees = try container.decode(key: .degrees)
        gust = try? container.decode(key: .gust)
    }

}
