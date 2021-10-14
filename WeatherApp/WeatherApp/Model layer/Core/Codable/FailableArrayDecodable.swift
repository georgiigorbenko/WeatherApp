//
//  FailableArrayDecodable.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 08.06.2021.
//  Copyright © 2021 Verb. All rights reserved.
//

import Foundation

struct FailableArrayDecodable<Base: APIResponse>: APIResponse {
    
    let elements: [Base]
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.singleValueContainer()
        elements = try container.decode([FailableDecodable<Base>].self).compactMap { $0.base }
    }
    
    init(any: Any?) throws {
        
        guard let json = any as? JSONArray else { throw ModelError.parsingError }
        try self.init(from: json.data)
    }
    
}
