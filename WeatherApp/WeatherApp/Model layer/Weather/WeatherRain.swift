//
//  WeatherRain.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import Foundation

protocol WeatherRain: APIResponse {
    
    var oneHour: Double { get }
}

struct WeatherRainProducer: WeatherRain {
    
    var oneHour: Double
    
    private enum CodingKeys: String, CodingKey {
        
        case oneHour = "1h"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        oneHour = try container.decode(key: .oneHour)
    }

}
