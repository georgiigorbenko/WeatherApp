//
//  TodayViewController.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import UIKit

class TodayViewController: WViewController {
    
    // MARK: - Private properties
    
    private let weatherService = WeatherService()
    private let locationService = LocationService()
    private var weather: Weather?
    
    // MARK: UI
    
    private var contentView: TodayView {
        
        return view as! TodayView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        view = TodayView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Today"
        setupInitialState()
    }
    
}

// MARK: - Public type definitions
extension TodayViewController {
    
}

// MARK: - Private methods
private extension TodayViewController {
    
    func setupInitialState() {
        
        contentView.refreshControl.addTarget(self, action: #selector(refreshControlDidFire), for: .valueChanged)
        contentView.shareButton.addTarget(self, action: #selector(shareButtonDidTap), for: .touchUpInside)
        
        self.contentView.contentStackView.isHidden = true
        reloadData()
    }
    
    func reloadData() {
        
        self.contentView.refreshControl.isVisible = true
        self.contentView.contentStackView.isHidden = true
        self.contentView.errorLabel.isHidden = true
        locationService.requestLoction(with: .find)
            .then {
                
                return self.weatherService.obtainCurrentWeather(searchText: nil,
                                                                lat: $0.coordinate.latitude,
                                                                lon: $0.coordinate.longitude)
            }
            .done {
                
                self.weather = $0
                self.contentView.fill(model: $0)
            }
            .ensure {
                
                self.contentView.refreshControl.isVisible = false
                self.contentView.contentStackView.isHidden = false
            }
            .catch {
                
                self.contentView.showError(message: $0.localizedDescription)
            }
    }
    
    // MARK: Handlers
    
    @objc func refreshControlDidFire() {
        
        reloadData()
    }
    
    @objc func shareButtonDidTap() {
        
        guard let weather = weather else { return }
        showShare(items: ["\(weather)"])
    }
    
}
