//
//  WTableViewDiffableDataSource.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

class WTableViewDiffableDataSource<Section: Hashable, Item: Hashable>: UITableViewDiffableDataSource<Section, Item> {
    
    convenience init(_ tableView: UITableView, _ cellProvider: @escaping CellProvider) {
        self.init(tableView: tableView, cellProvider: cellProvider)
    }
    
}
