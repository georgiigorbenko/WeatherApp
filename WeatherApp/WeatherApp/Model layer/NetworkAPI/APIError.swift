//
//  APIError.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 16.03.2021.
//  Copyright © 2021 Verb. All rights reserved.
//

import Alamofire
import Moya

enum APIError: LocalizedError {
    
    case connectionError
    case cancelled
    case timedOut
    case dataNotAllowed
    case serverError(ServerError)
    case moyaError(MoyaError)
    case afError(AFError)
    
    init(moyaError: MoyaError) {
        
        switch moyaError {
        case .underlying(let afError as AFError, _):
            switch afError {
            case let .sessionTaskFailed(error as URLError):
                switch error.code {
                case .notConnectedToInternet, .dataNotAllowed, .networkConnectionLost:
                    self = .connectionError
                case .timedOut:
                    self = .timedOut
                case .dataNotAllowed:
                    self = .dataNotAllowed
                default:
                    self = .afError(afError)
                }
            case .explicitlyCancelled:
                self = .cancelled
            default:
                self = .moyaError(moyaError)
            }
        default:
            self = .moyaError(moyaError)
        }
    }
    
    var errorDescription: String? {
        
        switch self {
        case .connectionError:
            return "Please check your network connection."
        case let .serverError(error):
            return error.errorDescription
        case let .moyaError(error):
            return error.errorDescription
        case let .afError(error):
            return error.errorDescription
        default:
            return nil
        }
    }
    
}

extension APIError: Equatable {
    
    /// Compares two APIError objects
    /// If both compared instances are .afError(AFError) these method will return false as AFError is not conformed to Equatable.
    /// Please compare AFError objects manually in that case
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        
        switch (lhs, rhs) {
        case (.timedOut, .timedOut):
            return true
        case (.connectionError, .connectionError):
            return true
        case (.cancelled, .cancelled):
            return true
        case (.dataNotAllowed, .dataNotAllowed):
            return true
        case let (.serverError(lError), .serverError(rError)):
            return lError.type == rError.type && lError.message == rError.message
        default:
            return false
        }
    }
    
}
