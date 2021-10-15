//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

enum WeatherStateType: String, APIResponse {
    
    case rain = "Rain"
    case snow = "Snow"
    case sunny = "Sunny"
    case extreme = "Extreme"
    case clear = "Clear"
    case clouds = "Clouds"
    case haze = "Haze"
    
    var icon: Design.Icon {
        
        switch self {
        case .rain:
            return .cloudRain
        case .snow:
            return .cloudSnow
        case .sunny, .clear:
            return .sunMax
        case .extreme:
            return .cloudBoltRainFill
        case .clouds:
            return .cloudFill
        case .haze:
            return .sunHaze
        }
    }
}

protocol WeatherInfo: APIResponse {
    
    var id: Int { get }
    var main: WeatherStateType { get }
    var detail: String? { get }
}

struct WeatherInfoProducer: WeatherInfo {
    
    var id: Int
    var main: WeatherStateType
    var detail: String?
    
    private enum CodingKeys: String, CodingKey  {
        
        case id = "id"
        case main = "main"
        case detail = "description"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(key: .id)
        main = try container.decode(key: .main)
        detail = try? container.decode(key: .detail)
    }
    
}
