//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Moya
import PromiseKit

class WeatherService {
    
    // MARK: - Private properties
    
    private let networkAPI = NetworkAPI<Request>()
}

// MARK: - Public methods
extension WeatherService {
    
    func obtainCurrentWeather(searchText: String?, lat: Double, lon: Double) -> Promise<Weather> {
        
        let parameters = CurrentWeatherParametersProducer(lat: lat, lon: lon, searchText: searchText)
        return networkAPI.request(.getCurrentWeather(parameters)).map { try WeatherProducer(from: $0.content) }
    }
    
    func obtain5DayForecast(searchText: String?, lat: Double, lon: Double) -> Promise<Forecast> {
        
        let parameters = CurrentWeatherParametersProducer(lat: lat, lon: lon, searchText: searchText)
        return networkAPI.request(.get5DayForecast(parameters)).map { try ForecastProducer(from: $0.content) }
    }
    
}

// MARK: - Private type definitions
private extension WeatherService {
    
    enum Request: APITargetType {
        
        case getCurrentWeather(_ parameters: APIJSONParameters)
        case get5DayForecast(_ parameters: APIJSONParameters)
        
        var path: String {
        
            switch self {
            case .getCurrentWeather:
                return "/weather"
            case .get5DayForecast:
                return "/forecast"
            }
        }
        
        var method: Moya.Method {
            
            switch self {
            case .getCurrentWeather, .get5DayForecast:
                return .get
            }
        }
        
        var task: Task {
            
            switch self {
            case .getCurrentWeather(let parameters), .get5DayForecast(let parameters):
                return .requestParameters(parameters: parameters.content, encoding: parameters.encoding)
            }
        }
        
    }
    
}
