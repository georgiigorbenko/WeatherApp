//
//  APIResponse.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 07.06.2021.
//  Copyright © 2021 Verb. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]
typealias JSONArray = [JSON]

protocol APIResponse: Decodable {
    
    init(from data: Data) throws
    init(from json: JSON) throws
}

extension APIResponse {
    
    init(from json: JSON) throws {
        
        let data = try JSONSerialization.data(withJSONObject: json, options: .fragmentsAllowed)
        try self.init(from: data)
    }
    
    init(from data: Data) throws {
        
        try self.init(from: data, decoder: BJSONDecoder())
    }
    
    init(from data: Data, decoder: BJSONDecoder) throws {
        
        self = try decoder.decode(Self.self, from: data)
    }
    
    init(any: Any?) throws {
        
        guard let json = any as? JSON else {
            
            throw NSError()
        }
        try self.init(from: json)
    }
    
}

extension Data {
    
    var json: JSON {
        
        return (try? JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) as? JSON) ?? [:]
    }
    
}

extension JSON {
    
    var data: Data {
        
        return (try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)) ?? Data()
    }
    
}

extension Array where Element == JSON {
    
    var data: Data {
        
        return (try? JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)) ?? Data()
    }
    
}
