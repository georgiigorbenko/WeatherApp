//
//  APITargetType.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 07.06.2021.
//  Copyright © 2021 Verb. All rights reserved.
//

import Moya

protocol APITargetType: TargetType {
    
    var httpHeaders: HTTPHeadersContainer { get }
}

extension APITargetType {
    
    var baseURL: URL {
        
        guard let url = URL(string: App.Network.url) else { fatalError("Base url is incorrect") }
        return url
    }
    
    var sampleData: Data { return Data() }
    
    var httpHeaders: HTTPHeadersContainer {
    
        return HTTPHeadersContainer()
    }
    
    var headers: [String : String]? {
        
        return httpHeaders.content
    }
    
}
