//
//  HTTPHeadersContainer.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 07.06.2021.
//  Copyright © 2021 Verb. All rights reserved.
//

import Foundation

struct HTTPHeadersContainer {
    
    // MARK: - Public properties
    
    var content: [String: String]
    
    // MARK: - Lifecycle
    
    init() {
        
        content = [:]
    }

    init(_ content: [String: String]) {
        
        self.content = content
    }

}

// MARK: - Public methods
extension HTTPHeadersContainer {
    
    subscript(key: Key) -> String? {
        
        set { content[key.rawValue] = newValue }
        get { return content[key.rawValue] }
    }
    
}

// MARK: - Public type definitions
extension HTTPHeadersContainer {
    
    enum Key: String {
        
        case csrfToken = "X-CSRF-Token"
        case authorization = "Authorization"
        case api = "API-Version"
        case platform = "Application-Platform"
        case version = "Application-Version"
        case contentType = "Content-type"
    }
    
}
