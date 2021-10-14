//
//  ServerError.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 27.01.2020.
//  Copyright © 2020 Verb. All rights reserved.
//

import Foundation

enum ServerErrorType: Int, APIResponse {
    
    case missingApplication = 404
    case authenticationError = 401
    case unknownServerError = 500
    case unknown = -1
}

protocol ServerError: APIResponse, LocalizedError {
    
    var message: String { get }
    var type: ServerErrorType { get set }
}

struct ServerErrorProducer: ServerError {

    var message: String
    var type: ServerErrorType
    
    var errorDescription: String? {
        
        return message
    }
    
    private enum CodingKeys: String, CodingKey {
        
        case message = "error"
        case type = "code"
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(key: .message)
        type = .unknown//try container.decode(key: .type)
    }
    
}
