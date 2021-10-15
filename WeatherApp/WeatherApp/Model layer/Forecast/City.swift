//
//  City.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import Foundation

protocol City: APIResponse {
    
    var id: Int { get }
    var name: String? { get }
    var coordinates: Coordinates? { get }
    var country: String? { get }
    var timeZone: Int { get }
    var sunrise: Date { get }
    var sunset: Date { get }
}

struct CityProducer: City {
    
    var id: Int
    var name: String?
    var coordinates: Coordinates?
    var country: String?
    var timeZone: Int
    var sunrise: Date
    var sunset: Date
    
    private enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case coordinates = "coordinates"
        case country = "country"
        case timeZone = "timezone"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(key: .id)
        name = try? container.decode(key: .name)
        coordinates = try? container.decode(CoordinatesProducer.self, key: .coordinates)
        country = try? container.decode(key: .country)
        timeZone = try container.decode(key: .timeZone)
        sunrise = try container.decode(key: .sunrise)
        sunset = try container.decode(key: .sunset)
    }
    
}
