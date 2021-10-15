//
//  Weather.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

protocol Weather: APIResponse {
    
    var id: Int? { get }
    var coordinaters: Coordinates? { get }
    var info: [WeatherInfo] { get }
    var base: String? { get }
    var main: WeatherMain { get }
    var visibility: Double { get }
    var wind: Wind { get }
    var clouds: Clouds { get }
    var date: Date { get }
    var sys: WeatherSys { get }
    var timeZone: Int? { get }
    var name: String? { get }
    var rain: WeatherRain? { get }
}

struct WeatherProducer: Weather {
    
    var id: Int?
    var coordinaters: Coordinates?
    var info: [WeatherInfo]
    var base: String?
    var main: WeatherMain
    var visibility: Double
    var wind: Wind
    var clouds: Clouds
    var date: Date
    var sys: WeatherSys
    var timeZone: Int?
    var name: String?
    var rain: WeatherRain?
    
    private enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case coordinaters = "coord"
        case info = "weather"
        case base = "base"
        case main = "main"
        case visibility = "visibility"
        case wind = "wind"
        case clouds = "clouds"
        case date = "dt"
        case sys = "sys"
        case timeZone = "timezone"
        case name = "name"
        case rain = "rain"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(key: .id)
        coordinaters = try? container.decode(CoordinatesProducer.self, key: .coordinaters)
        info = try container.decode(ArrayDecodable<WeatherInfoProducer>.self, key: .info).elements
        base = try? container.decode(key: .base)
        main = try container.decode(WeatherMainProducer.self, key: .main)
        visibility = try container.decode(key: .visibility)
        wind = try container.decode(WindProducer.self, key: .wind)
        clouds = try container.decode(CloudsProducer.self, key: .clouds)
        date = try container.decode(key: .date)
        sys = try container.decode(WeatherSysProducer.self, key: .sys)
        timeZone = try? container.decode(key: .timeZone)
        name = try? container.decode(key: .name)
        rain = try? container.decode(WeatherRainProducer.self, key: .rain)
    }
    
}

