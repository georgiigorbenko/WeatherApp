//
//  ModelError.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 27.01.2020.
//  Copyright © 2020 Verb. All rights reserved.
//

import Foundation

enum ModelError: LocalizedError {
    
    /// An error occured while object parsing. For example, enums with raw types.
    case parsingError
    /// An error occurred when in parameters nullable property is declared but must be in request because of api rules
    case requiredEncodingProperty
    
    var errorDescription: String {
        
        switch self {
        case .parsingError:
            return "Something gonna wrong getting object"
        case .requiredEncodingProperty:
            return "Missed required properties"
        }
    }
    
}
