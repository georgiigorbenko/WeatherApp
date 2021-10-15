//
//  WorldSide.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import Foundation

enum WorldSide: String, CaseIterable {
    
    case n, nne, ne, ene, e, ese, se, sse, s, ssw, sw, wsw, w, wnw, nw, nnw
    
    var description: String { rawValue.uppercased() }
    
    init<D: BinaryFloatingPoint>(_ degrees: D) {
        
        let angle = (degrees.truncatingRemainder(dividingBy: 360) + 360).truncatingRemainder(dividingBy: 360)
        self = Self.allCases[Int((angle + 11.25).truncatingRemainder(dividingBy: 360) / 22.5)]
    }
        
}
