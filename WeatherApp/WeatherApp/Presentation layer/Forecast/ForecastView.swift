//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

class ForecastView: UIView {
    
    // MARK: Public properties
    
    let refreshControl = WRefreshControl()
    
    // MARK: - Private properties
    
    private var sections = [ForecastSectionBox]()
    
    // MARK: UI
    
    private lazy var tableView = WTableView()
    private lazy var dataSource = WTableViewDiffableDataSource<Section, Item>(tableView)
        { tableView, indexPath, model in
        
        let factory = ForecastCellFactory(model.value)
        return tableView.dequeueReusableCell(withFactory: factory, for: indexPath)
    }

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
extension ForecastView {
    
    func set(sections: [ForecastSectionBox], animated: Bool) {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections(sections)
        for section in sections {
            
            snapshot.appendItems(section.value.cells, toSection: section)
        }
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
    
}

// MARK
extension ForecastView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let section = dataSource.snapshot().sectionIdentifiers[safe: section] else { return nil }
        let factory = ForecastHeaderFactory(section.value.header)
        return tableView.dequeueReusableHeaderFooterView(withFactory: factory)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44
    }
    
}

// MARK: - Private type definitions
private extension ForecastView {
    
    typealias Section = ForecastSectionBox
    typealias Item = ForecastCellBox
    
}

// MARK: - Private methods
extension ForecastView {
    
    func setupUI() {
    
        backgroundColor = Design.Color.white()
        
        tableView.backgroundColor = Design.Color.separator()
        tableView.register(classModels: [ForecastCellFactory.self])
        tableView.registerHeaderFooterView(classModels: [ForecastHeaderFactory.self])
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        tableView.separatorInset.left = 78 + Design.Constants.View.insets.left // by Design
        tableView.separatorInset.right = 0
        tableView.allowsSelection = false
        dataSource.defaultRowAnimation = .fade
        
        addSubview(tableView)
        tableView.edgesToSuperview(usingSafeArea: true)
    }
    
}
