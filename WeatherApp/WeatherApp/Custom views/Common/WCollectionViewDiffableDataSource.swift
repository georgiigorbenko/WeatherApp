//
//  WCollectionViewDiffableDataSource.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

class WCollectionViewDiffableDataSource<Section: Hashable, Item: Hashable>: UICollectionViewDiffableDataSource<Section, Item> {
    
    convenience init(_ collectionView: UICollectionView, _ cellProvider: @escaping CellProvider) {
        self.init(collectionView: collectionView, cellProvider: cellProvider)
    }
    
}
