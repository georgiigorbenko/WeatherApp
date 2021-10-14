//
//  DesignIcon.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 18.08.2021.
//  Copyright © 2021 Georgy Gorbenko. All rights reserved.
//

import UIKit

extension Design {
    
    enum Icon: String {
        
        case back = "ic_back"
        case account = "ic_account"
        
        func callAsFunction() -> UIImage {
        
            return UIImage(named: rawValue) ?? UIImage()
        }
    }
    
}
