//
//  LocationServiceError.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import Foundation

enum LocationServiceError: LocalizedError {
 
    case deniedAuthorization
    case serviceDisabled
    case noLocationFound
    
    var errorDescription: String? {
        
        switch self {
        case .deniedAuthorization:
            return "User denied location service authorization"
        case .serviceDisabled:
            return "Location service is disabled"
        case .noLocationFound:
            return "Location is not found"
        }
    }
    
}
