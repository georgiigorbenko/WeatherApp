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
    
    static var scheme: Scheme { .release  }
    
    // MARK: - Private properties
    
    private static var serverName: String {
        
        switch scheme {
        case .release:
            return ""
        }
    }
    
}

// MARK: - UX
extension App {
    
    struct UX {
        
        static var temperatureUnit: UnitTemperature { return .celsius }
        static var pressureUnit: UnitPressure { return .hectopascals }
        static var speedUnit: UnitSpeed { return .kilometersPerHour }
    }
    
}

// MARK: - Network
extension App {
    
    struct Network {
        
        static var url: String { return "\(baseUrl)" }
        static var apiKey: String { return "a2cf97dbf4msh3d1553e32bba1cbp160437jsnc34829a86aba" }
        static var apiHost: String { return "community-open-weather-map.p.rapidapi.com" }
        static var apiVersion: String { return "1" }
        static var platform: String { return "iOS" }
        static var appVersion: String { return Bundle.appVersion }
        
        // MARK: - Private properties
        
        private static var baseUrl: String { return "https://community-open-weather-map.p.rapidapi.com" }
    }
    
}

// MARK: - Debug
extension App {
    
    struct Debug {
        
        static var isAPILogEnabled: Bool { return false }
    }
    
}
