//
//  WViewController.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import UIKit

class WViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appereance = UINavigationBarAppearance()
        appereance.titleTextAttributes = [.foregroundColor: Design.Color.navigationBarTitle(),
                                          .font: Design.Font.Robotto.bold(16)]
        appereance.backgroundColor = Design.Color.navigationBar()
        appereance.shadowImage = UIImage.gradientImage(size: CGSize(width: UIScreen.main.bounds.width, height: 1),
                                                       colors: [.purple, .orange, .green, .blue, .yellow, .red])
        
        navigationItem.standardAppearance = appereance
        navigationItem.compactAppearance = appereance
        navigationItem.scrollEdgeAppearance = appereance
    }
    
}
