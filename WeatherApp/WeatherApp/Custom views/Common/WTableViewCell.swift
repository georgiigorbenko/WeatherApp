//
//  WTableViewCell.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

class WTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
}
