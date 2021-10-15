//
//  ArrayDecodable.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 24.04.2020.
//  Copyright © 2020 Verb. All rights reserved.
//

import Foundation

struct ArrayDecodable<Base: APIResponse>: APIResponse {

    let elements: [Base]

    init(from decoder: Decoder) throws {
           
        let container = try decoder.singleValueContainer()
        elements = try container.decode([Base].self)
    }
    
    init(any: Any?) throws {
        
        guard let json = any as? JSONArray else { throw ModelError.parsingError }
        try self.init(from: json.data)
    }
    
}
