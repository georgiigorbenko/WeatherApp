//
//  String+Project.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation

extension String {
    
    static func joined(_ start: String?, _ other: String?, separator: String = " ") -> String? {
        
        return start?.joined(other, separator: separator) ?? other
    }
    
    func joined(_ other: String?, separator: String = " ") -> String {
        
        let other = other ?? ""
        switch (isEmpty, other.isEmpty) {
        case (false, false):
            return self + separator + other
        case (true, true):
            return ""
        case (true, false):
            return other
        case (false, true):
            return self
        }
    }
    
}
