//
//  CurrentWeatherParameters.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

protocol CurrentWeatherParameters: APIJSONParameters {
    
    var lat: Double { get }
    var lon: Double { get }
    var searchText: String? { get }
}

struct CurrentWeatherParametersProducer: CurrentWeatherParameters {
    
    var lat: Double
    var lon: Double
    var searchText: String?
    
    var encoding: APIParametersEncoding {  return APIURLEncoding.default }
    
    private enum CodingKeys: String, CodingKey  {
        
        case lat = "lat"
        case lon = "lon"
        case searchText = "q"
        case units = "units"
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lon, forKey: .lon)
        try container.encodeIfPresent(searchText, forKey: .searchText)
        try container.encode("metric", forKey: .units)
    }
    
}
