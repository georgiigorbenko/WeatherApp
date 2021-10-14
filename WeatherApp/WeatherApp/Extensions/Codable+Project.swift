//
//  Codable+Project.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 23.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import Foundation

extension KeyedDecodingContainer {
    
    func decode<T: Decodable>(_ type: T.Type = T.self, key: KeyedDecodingContainer.Key) throws -> T {
        
        return try decode(type, forKey: key)
    }
    
    func decode<T: Decodable>(_ type: T.Type = T.self, key: KeyedDecodingContainer.Key, default: T) throws -> T {
        
        return (try? decodeIfPresent(type, forKey: key)) ?? `default`
    }

    func decodeIfPresent<T: Decodable>(_ type: T.Type = T.self, key: KeyedDecodingContainer.Key) throws -> T? {
        
        return try decodeIfPresent(type, forKey: key)
    }
    
}
