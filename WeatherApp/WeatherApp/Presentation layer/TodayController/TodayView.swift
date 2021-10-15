//
//  TodayView.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import UIKit
import TinyConstraints

class TodayView: UIView {
    
    // MARK: - Public properties
    
    // MARK: UI
    
    let refreshControl = WRefreshControl()
    let contentStackView = WStackView(axis: .vertical, alignment: .center, spacing: 14)
    let shareButton = WButton(font: .Robotto.$regular(16), titleColor: .red, title: "Share")
    let errorLabel = WLabel(font: .Robotto.$regular(16), textColor: .black, numberOfLines: 0, textAlligment: .center)
    
    // MARK: - Private properties
    
    private let measurementFormatter = WMeasurementFormatter()
    
    // MARK: UI
    
    private let weatherImageView = WImageView(tintColor: .orange)
    private let locationLabel = WLabel(font: .Robotto.$bold(16), textColor: .black)
    private let temperatureLabel = WLabel(font: .Robotto.$medium(22), textColor: .link)
    private let humidityLabel = WLabel()
    private let mercuryLabel = WLabel(text: "1.0 mm")
    private let pressureLabel = WLabel()
    private let speedLabel = WLabel()
    private let directionLabel = WLabel()
    private let infoStackView = WStackView(axis: .vertical, distribution: .fillEqually, spacing: 16)
    private let scrollView = WScrollView()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
}

// MARK: - Public methods
extension TodayView {
    
    func fill(model: Weather) {
        
        weatherImageView.image = model.info.first?.main.icon(config: .init(pointSize: 56, weight: .regular))
        locationLabel.text = String.joined(model.name, model.sys.country, separator: ", ")
        
        let temperatureMeasurement = Measurement(value: model.main.temperature.rounded(.up),
                                                 unit: App.UX.temperatureUnit)
        temperatureLabel.text = String.joined(
            measurementFormatter.string(from: temperatureMeasurement),
            model.info.first?.main.rawValue,
            separator: " | ")
        
        humidityLabel.text = "\(model.main.humidity) %"
        
        let pressureMeasurement = Measurement(value: model.main.pressure, unit: App.UX.pressureUnit)
        pressureLabel.text = measurementFormatter.string(from: pressureMeasurement)
        
        let speedMeasurement = Measurement(value: model.wind.speed, unit: App.UX.speedUnit)
        speedLabel.text = measurementFormatter.string(from: speedMeasurement)
        
        directionLabel.text = WorldSide(model.wind.degrees).description
        
        if let rain = model.rain?.oneHour {
            
            mercuryLabel.text = "\(rain) mm"
        }
        else {
            
            mercuryLabel.text = nil
        }
        mercuryLabel.superview?.isHidden = mercuryLabel.text == nil
    }
    
    func showError(message: String?) {
        
        contentStackView.isHidden = true
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
}

// MARK: - Private type definitions
private extension TodayView {
    
    class DashedButton: WButton {
        
        private let shapeLayer = CAShapeLayer()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            layer.addSublayer(shapeLayer)
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            
            layer.addSublayer(shapeLayer)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            let shapeRect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

            shapeLayer.bounds = shapeRect
            shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
            shapeLayer.fillColor = UIColor.clear.cgColor
            shapeLayer.strokeColor = Design.Color.dash().cgColor
            shapeLayer.lineWidth = 1
            shapeLayer.lineDashPattern = [2, 2]
            shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 2).cgPath
        }
    }
    
}

// MARK: - Private methods
private extension TodayView {
    
    func setupUI() {
        
        backgroundColor = Design.Color.white()
        scrollView.refreshControl = refreshControl
        errorLabel.isHidden = true
        
        let contentView = UIView()
        
        let firstRowStackView = WStackView(
            arrangedSubviews: [
                buildInfoItemStackView(image: .sunMax, view: humidityLabel),
                buildInfoItemStackView(image: .drop, view: mercuryLabel),
                buildInfoItemStackView(image: .thermometer, view: pressureLabel)
            ], axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: 8)
        
        let secondRowStackView = WStackView(
            arrangedSubviews: [
                buildInfoItemStackView(image: .arrowshapeTurnUpForward, view: speedLabel),
                buildInfoItemStackView(image: .safari, view: directionLabel)
            ], axis: .horizontal, distribution: .fillEqually, alignment: .fill, spacing: 8)
        
        infoStackView.addArrangedSubviews([firstRowStackView, secondRowStackView])
        contentStackView.addArrangedSubviews([weatherImageView,
                                              locationLabel,
                                              temperatureLabel,
                                              infoStackView,
                                              shareButton])
        
        let locationImageView = WImageView(image: Design.Icon.safari(config: .init(pointSize: 12, weight: .medium)))
        locationImageView.tintColor = Design.Color.link()
        
        let topSeparator = UIView()
        let bottomSeparator = UIView()
        
        addSubview(scrollView)
        addSubview(errorLabel)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentStackView.addSubview(locationImageView)
        
        for view in [topSeparator, bottomSeparator] {
            
            contentStackView.addSubview(view)
            view.height(1)
            view.backgroundColor = Design.Color.separator()
            view.centerX(to: infoStackView)
            view.width(to: infoStackView, multiplier: 0.5)
        }
        topSeparator.bottom(to: infoStackView, offset: 24)
        bottomSeparator.top(to: infoStackView, offset: -24)
        locationImageView.rightToLeft(of: locationLabel, offset: -8)
        locationImageView.centerY(to: locationLabel)
        errorLabel.edgesToSuperview(excluding: [.top, .bottom], insets: Design.Constants.View.insets)
        errorLabel.centerYToSuperview()
        scrollView.edgesToSuperview(usingSafeArea: false)
        contentView.edgesToSuperview()
        contentView.width(to: self, priority: .defaultHigh)
        contentView.height(to: self, priority: .defaultLow)
        contentStackView.edgesToSuperview(excluding: [.top, .bottom],
                                          insets: Design.Constants.View.insets,
                                          usingSafeArea: true)
        contentStackView.bottomToSuperview(offset: -Design.Constants.View.insets.bottom,
                                           relation: .equalOrLess,
                                           usingSafeArea: true)
        contentStackView.topToSuperview(offset: 48, usingSafeArea: true)
        contentStackView.setCustomSpacing(64, after: temperatureLabel)
        contentStackView.setCustomSpacing(64, after: infoStackView)
        weatherImageView.setHugging(UILayoutPriority(255), for: .vertical)
        infoStackView.edgesToSuperview(excluding: [.top, .bottom])
        firstRowStackView.edgesToSuperview(excluding: [.top, .bottom])
        secondRowStackView.edgesToSuperview(excluding: [.top, .bottom])
    }
    
    func buildInfoItemStackView(image: Design.Icon, view: UIView) -> WStackView {
        
        let button = DashedButton(image: image, tintColor: .orange)
        button.backgroundColor = Design.Color.link().with(alpha: 0.1)
        button.contentEdgeInsets = UIEdgeInsets(offset: 3)
        button.size(CGSize(width: 24, height: 24))
        button.isUserInteractionEnabled = false
        return WStackView(arrangedSubviews: [button, view], axis: .vertical, alignment: .center, spacing: 4)
    }
    
}
