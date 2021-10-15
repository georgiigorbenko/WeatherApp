//
//  WeatherMain.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

protocol WeatherMain: APIResponse {
    
    var temperature: Double { get }
    var feel: Double { get }
    var min: Double { get }
    var max: Double { get }
    var pressure: Double { get }
    var humidity: Double { get }
}

struct WeatherMainProducer: WeatherMain {
    
    var temperature: Double
    var feel: Double
    var min: Double
    var max: Double
    var pressure: Double
    var humidity: Double
    
    private enum CodingKeys: String, CodingKey {
        
        case temperature = "temp"
        case feel = "feels_like"
        case min = "temp_min"
        case max = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decode(key: .temperature)
        feel = try container.decode(key: .feel)
        min = try container.decode(key: .min)
        max = try container.decode(key: .max)
        pressure = try container.decode(key: .pressure)
        humidity = try container.decode(key: .humidity)
    }

}
