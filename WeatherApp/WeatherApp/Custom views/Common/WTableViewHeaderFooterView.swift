//
//  File.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

class WTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    override func updateConfiguration(using state: UIViewConfigurationState) {
        
        backgroundConfiguration = .clear()
    }
    
    private func setup() {
        
        contentView.backgroundColor = .clear
    }
    
}
