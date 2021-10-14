//
//  Bundle+Project.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 21.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import Foundation

extension Bundle {
    
    class var appVersion: String {
        
        guard let dictionary = Bundle.main.infoDictionary else { return "" }
        guard let version = dictionary["CFBundleShortVersionString"] as? String else { return "" }
        return version
    }
    
}
