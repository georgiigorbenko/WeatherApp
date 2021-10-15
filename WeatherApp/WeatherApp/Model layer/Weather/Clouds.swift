//
//  Clouds.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

protocol Clouds: APIResponse {
    
    var all: Double { get }
}

struct CloudsProducer: Clouds {
    
    var all: Double
    
    private enum CodingKeys: String, CodingKey {
        
        case all = "all"
        case degrees = "deg"
        case gust = "gust"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        all = try container.decode(key: .all)
    }

}
