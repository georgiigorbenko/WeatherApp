//
//  WeatherSys.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

protocol WeatherSys: APIResponse {
    
    var type: Double? { get }
    var id: Int? { get }
    var country: String? { get }
    var sunrise: Date? { get }
    var sunset: Date? { get }
}

struct WeatherSysProducer: WeatherSys {
    
    var type: Double?
    var id: Int?
    var country: String?
    var sunrise: Date?
    var sunset: Date?
    
    private enum CodingKeys: String, CodingKey {
        
        case type = "type"
        case id = "id"
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try? container.decode(key: .type)
        id = try? container.decode(key: .id)
        country = try? container.decode(key: .country)
        sunrise = try? container.decode(key: .sunrise)
        sunset = try? container.decode(key: .sunset)
    }

}
