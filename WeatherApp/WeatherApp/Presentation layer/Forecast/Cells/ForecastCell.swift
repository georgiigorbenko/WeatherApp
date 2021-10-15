//
//  ForecastCell.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

class ForecastCell: WTableViewCell {
    
    // MARK: - Private properties
    
    private let timeFormatter = WDateFormatter(type: .timeShort)
    private let measurementFormatter = WMeasurementFormatter()
    
    // MARK: UI
    
    private let weatherImageView = WImageView( contentMode: .scaleToFill, tintColor: .orange)
    private let titleLabel = WLabel(font: .Robotto.$regular(16), textColor: .black)
    private let detailLabel = WLabel(font: .Robotto.$regular(14), textColor: .black)
    private let temperatureLabel = WLabel(font: .Robotto.$bold(26), textColor: .link)
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
}

// MARK: - Private methods
private extension ForecastCell {
    
    func setupUI() {
        
        contentView.backgroundColor = Design.Color.white()
        let centerStackView = WStackView(arrangedSubviews: [titleLabel, detailLabel],
                                         axis: .vertical,
                                         spacing: 8)
        
        let contentStackView = WStackView(arrangedSubviews: [weatherImageView, centerStackView, temperatureLabel],
                                          axis: .horizontal,
                                          alignment: .center, spacing: 16)
        
        contentView.addSubview(contentStackView)
        contentStackView.edgesToSuperview(insets: Design.Constants.View.insets.new(top: 16, bottom: 16))
        weatherImageView.setHugging(UILayoutPriority(252), for: .horizontal)
        temperatureLabel.setHugging(UILayoutPriority(253), for: .horizontal)
    }
    
    func configure(model: ForecastCellData) {
        
        weatherImageView.image = model.weatherStateType.icon(config: .init(pointSize: 48, weight: .regular))
        titleLabel.text = timeFormatter.string(fromDate: model.date)
        detailLabel.text = model.detail
        temperatureLabel.text = measurementFormatter.string(for: Measurement(value: model.temperature.rounded(.up),
                                                                             unit: App.UX.temperatureUnit))
    }
    
}

struct ForecastCellFactory: CollectionFactory {
    
    typealias CollectionItemType = ForecastCell
    
    private let model: ForecastCellData
    
    init(_ model: ForecastCellData) {
        
        self.model = model
    }
    
    func setup(item: ForecastCell) {
        
        item.configure(model: model)
    }
    
}
