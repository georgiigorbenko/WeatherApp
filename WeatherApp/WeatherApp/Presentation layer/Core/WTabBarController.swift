//
//  WTabBarController.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import UIKit

class WTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UITabBarAppearance()
        appearance.shadowColor = Design.Color.separator()
        
        tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            
            tabBar.scrollEdgeAppearance = appearance
        }
    }
    
}
