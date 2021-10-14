//
//  Array+Project.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 16.06.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        
        guard startIndex..<endIndex ~= index else { return nil }
        return self[index]
    }
    
}
