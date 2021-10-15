//
//  ForecastHeaderView.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

class ForecastHeaderView: WTableViewHeaderFooterView {
    
    // MARK: - Private properties
    
    // MARK: UI
    
    private let titleLabel = WLabel(font: .Robotto.$regular(18), textColor: .black)
    
    // MARK: - Lifecycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
}

// MARK: - Private methods
private extension ForecastHeaderView {

    func setupUI() {
    
        contentView.backgroundColor = Design.Color.white()
        let bottomView = UIView()
        let topView = UIView()
        
        contentView.addSubview(titleLabel)
        for view in [topView, bottomView] {
            
            contentView.addSubview(view)
            view.backgroundColor = Design.Color.separator()
            view.height(1)
        }
        topView.edgesToSuperview(excluding: [.bottom])
        bottomView.edgesToSuperview(excluding: [.top])
        titleLabel.edgesToSuperview(insets: Design.Constants.View.insets.new(top: 12, bottom: 12))
    }
    
    func configure(model: ForecastHeaderData) {
        
        titleLabel.text = model.name
    }
    
}

struct ForecastHeaderFactory: CollectionFactory {
    
    typealias CollectionItemType = ForecastHeaderView
    
    private let model: ForecastHeaderData
    
    init(_ model: ForecastHeaderData) {
        
        self.model = model
    }
    
    func setup(item: ForecastHeaderView) {
        
        item.configure(model: model)
    }
    
}
