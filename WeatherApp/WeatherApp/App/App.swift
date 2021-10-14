//
//  App.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 21.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

struct App {
    
    // MARK: - Enums
    
    enum Scheme {
        
        case release
    }
    
    // MARK: - Public properties
    
    static var scheme: Scheme {
        
        return .release
    }
    
    // MARK: - Private properties
    
    private static var serverName: String {
        
        switch scheme {
        case .release:
            return ""
        }
    }
    
}

// MARK: - KeychainKey
extension App {
    
    struct KeychainKey {
        
        /// Keys are used in keychain service.
        ///
        /// - Note: Repository key is not returned because it's used only to have an access to database.
        /// It also this eliminates the situation when cleaning keychain for all keys but repository key is still needed.
        static var allKeys: [String] { [] }
        static var repository: String { return "RepositoryEncryptionKeyIdentifier" }
    }
    
}

// MARK: - UX
extension App {
    
    struct UX {
        
        static var paginationLimit: Int { return 20 }
    }
    
}

// MARK: - Network
extension App {
    
    struct Network {
        
        static var url: String { return "\(baseUrl)/svc" }
        static var apiKey: String { return "QhjAXEfRW17zE5YcFj6aPiXZfwxMEX4e" }
        static var apiVersion: String { return "1" }
        static var platform: String { return "iOS" }
        static var appVersion: String { return Bundle.appVersion }
        
        // MARK: - Private properties
        
        private static var baseUrl: String { return "https://api.nytimes.com" }
    }
    
}

// MARK: - Debug
extension App {
    
    struct Debug {
        
        static var isAPILogEnabled: Bool { return true }
    }
    
}
