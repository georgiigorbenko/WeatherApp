//
//  ForecastViewController.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 14.10.2021.
//

import UIKit

class ForecastViewController: WViewController {
    
    // MARK: - Private properties
    
    private let weatherService = WeatherService()
    private let locationService = LocationService()
    private let dateFormatter = WDateFormatter(type: .custom("EEEE"))
    
    // MARK: UI
    
    private var contentView: ForecastView {
        
        return view as! ForecastView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        view = ForecastView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInitialState()
    }
    
}

// MARK: - Public type definitions
extension ForecastViewController {
    
}

// MARK: - Private methods
private extension ForecastViewController {
    
    func setupInitialState() {
        
        contentView.refreshControl.addTarget(self, action: #selector(refreshControlDidFire), for: .valueChanged)
        reloadData()
    }
    
    func reloadData() {
        
        contentView.refreshControl.isVisible = true
        
        locationService.requestLoction(with: .find)
            .then {
                
                return self.weatherService.obtain5DayForecast(searchText: nil,
                                                              lat: $0.coordinate.latitude,
                                                              lon: $0.coordinate.longitude)
            }
            .done {
                
                self.navigationItem.title = $0.city.name
                let groups: [(Date, [Weather])] = Dictionary(grouping: $0.list, by: {
                    
                    let date = Calendar.current.dateComponents([.day, .year, .month], from: $0.date)
                    return date
                }).compactMap { (key: DateComponents, value: [Weather]) in
                    
                    guard let date = Calendar.current.date(from: key) else { return nil }
                    return (date, value)
                }.sorted(by: { $0.0 < $1.0 })
                let sections: [ForecastSectionBox] = groups.map {
                    
                    let name = Calendar.current.isDateInToday($0.0)
                        ? "Today"
                        : self.dateFormatter.string(from: $0.0)
                    return ForecastSectionBox(
                        ForecastSectionDataProducer(
                            header: ForecastHeaderDataProducer(name: name),
                            date: $0.0,
                            cells: self.buildCells(weather: $0.1)))
                }
                self.contentView.set(sections: sections, animated: true)
            }
            .ensure {
                
                self.contentView.refreshControl.isVisible = false
            }
            .catch {
                
                self.showErrorAlert(with: $0.localizedDescription)
            }
    }
    
    func buildCells(weather: [Weather]) -> [ForecastCellBox] {
        
        return weather.compactMap {
            
            guard let weatherStateType = $0.info.first?.main else { return nil }
            return ForecastCellBox(ForecastCellDataProducer(weatherStateType: weatherStateType,
                                                            date: $0.date,
                                                            detail: weatherStateType.rawValue,
                                                            temperature: $0.main.temperature))
        }
    }
    
    // MARK: Handlers
    
    @objc func refreshControlDidFire() {
        
        reloadData()
    }
    
}

