//
//  DesignFont.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 18.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

extension Design {
    
    struct Font {
        
        private let size: CGFloat
        private let fontName: String
        private let weight: Weight
        
        fileprivate init(_ fontName: String, _ size: CGFloat, _ weight: Weight) {

            self.size = size
            self.fontName = fontName
            self.weight = weight
        }
        
        // Will be used for getting a font.
        func callAsFunction(_ size: CGFloat = 0) -> UIFont {
            
            let size = max(self.size, size)
            let font = UIFont(name: "\(fontName)-\(weight.rawValue)", size: size)
            return font ?? UIFont.systemFont(ofSize: size)
        }
        
    }

}

extension Design.Font {
    
    /// Use without prefix $ to get the font and with prefix $ to pass it as a parameter in any view factory.
    struct Robotto {
        
        @FontProvider(Robotto(.bold)) static var bold = Design.Font(Self.name, 0, .bold)
        @FontProvider(Robotto(.medium)) static var medium = Design.Font(Self.name, 0, .medium)
        @FontProvider(Robotto(.regular)) static var regular = Design.Font(Self.name, 0, .regular)
        @FontProvider(Robotto(.italic)) static var italic = Design.Font(Self.name, 0, .italic)
        
        private static let name = String(describing: Self.self)
        private let weight: Weight
        
        fileprivate init(_ weight: Weight) {

            self.weight = weight
        }
        
        // Will be use on passing Font type as a parameter in any view factory.
        func callAsFunction(_ size: CGFloat = 0) -> Design.Font {
            
            Design.Font(Self.name, size, weight)
        }
        
    }
    
    enum Weight: String {
        
        case bold = "Bold"
        case italic = "Italic"
        case medium = "Medium"
        case regular = "Regular"
    }
    
}

@propertyWrapper
struct FontProvider<T> {
    
    let wrappedValue: Design.Font
    let projectedValue: T
    
    init(wrappedValue: Design.Font, _ projectedValue: T) {
        
        self.wrappedValue = wrappedValue
        self.projectedValue = projectedValue
    }
    
}
