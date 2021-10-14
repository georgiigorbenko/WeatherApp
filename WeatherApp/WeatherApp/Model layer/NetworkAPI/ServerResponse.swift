//
//  ServerResponse.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 20.01.2020.
//  Copyright © 2020 Verb. All rights reserved.
//

import Foundation

struct ServerResponse {
    
    let content: Data
    
    init(object: Any) throws {
        
        content = try JSONSerialization.data(withJSONObject: object, options: .fragmentsAllowed)
    }
    
    init(data: Data) {
        
        content = data
    }
    
}
