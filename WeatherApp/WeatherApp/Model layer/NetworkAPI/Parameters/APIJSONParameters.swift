//
//  APIJSONParameters.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 20.01.2020.
//  Copyright © 2020 Verb. All rights reserved.
//

import Alamofire

protocol APIJSONParameters: APIParameters {
    
    var content: JSON { get }
    var encoding: APIParametersEncoding { get }
}

extension APIJSONParameters {
    
    var content: JSON {
        
        guard let data = try? BJSONEncoder().encode(self),
              let json = ((try? JSONSerialization.jsonObject(with: data, options: .allowFragments))
                            .flatMap { $0 as? JSON })
            else { return [:] }
        return json
    }
    
    var encoding: APIParametersEncoding {
        
        return APIJSONEncoding.default
    }
    
    func validate() throws {
        
        _ = try BJSONEncoder().encode(self)
    }
    
}
