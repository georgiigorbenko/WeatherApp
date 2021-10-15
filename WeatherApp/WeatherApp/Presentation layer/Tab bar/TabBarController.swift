//
//  TabBarController.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import Foundation
import UIKit

class TabBarController: WTabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

// MARK: - Private methods
private extension TabBarController {
    
    func setupUI() {
    
        let todayViewController = WNavigationController(rootViewController: TodayViewController())
        todayViewController.tabBarItem = WTabBarItem(title: "Today", image: .sunMax, selectedImage: nil)
        
        let forecastViewController = WNavigationController(rootViewController: ForecastViewController())
        forecastViewController.tabBarItem = WTabBarItem(title: "Forecast",
                                                        image: .cloudMoonBoltFill,
                                                        selectedImage: nil)
        
        setViewControllers([todayViewController, forecastViewController], animated: false)
    }
    
}
