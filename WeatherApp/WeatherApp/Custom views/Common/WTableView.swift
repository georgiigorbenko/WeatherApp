//
//  WTableView.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

class WTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        
        if #available(iOS 15, *) {
         
            sectionHeaderTopPadding = 0
        }
        tableFooterView = UIView()
        separatorInset = Design.Constants.View.insets.new(top: 0, bottom: 0)
        separatorColor = Design.Color.separator()
    }
    
}
