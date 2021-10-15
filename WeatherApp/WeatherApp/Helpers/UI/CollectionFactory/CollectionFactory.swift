//
//  CollectionFactory.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

protocol AnyCollectionFactory {
    
    static var wrappedType: UIView.Type { get }
    
    var identifier: String { get }
    func setup(anyItem: UIView)
}

protocol CollectionFactory: AnyCollectionFactory {
    
    associatedtype CollectionItemType: UIView
    
    func setup(item: CollectionItemType)
}

extension CollectionFactory {
    
    public static var wrappedType: UIView.Type {
        
        return CollectionItemType.self
    }
    
    public var identifier: String {
        
        return String(describing: type(of: self).wrappedType)
    }
    
    public func setup(anyItem: UIView) {
        
        guard let item = anyItem as? CollectionItemType else {
            
            fatalError("Given collection item is not an instance of \(String(describing: CollectionItemType.self))")
        }
        setup(item: item)
    }
}

extension UITableView {
    
    func dequeueReusableCell(withFactory factory: AnyCollectionFactory,
                             for indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dequeueReusableCell(withIdentifier: factory.identifier, for: indexPath)
        factory.setup(anyItem: cell)
        
        return cell
    }
    
    func dequeueReusableCell(withFactory factory: AnyCollectionFactory) -> UITableViewCell? {
        
        guard let cell = dequeueReusableCell(withIdentifier: factory.identifier) else { return nil }
        factory.setup(anyItem: cell)
        
        return cell
    }
    
    func dequeueReusableHeaderFooterView(withFactory factory: AnyCollectionFactory) -> UITableViewHeaderFooterView? {
        
        guard let header = dequeueReusableHeaderFooterView(withIdentifier: factory.identifier) else { return nil }
        factory.setup(anyItem: header)
        
        return header
    }
    
    func register(nibModels: [AnyCollectionFactory.Type]) {
        
        nibModels.forEach {
            
            let id = String(describing: $0.wrappedType)
            let nib = UINib(nibName: id, bundle: nil)
            register(nib, forCellReuseIdentifier: id)
        }
    }
    
    func register(classModels: [AnyCollectionFactory.Type]) {
        
        classModels.forEach {
            
            let id = String(describing: $0.wrappedType)
            register($0.wrappedType, forCellReuseIdentifier: id)
        }
    }
    
    func register(nibModel: AnyCollectionFactory.Type) {
        
        register(nibModels: [nibModel])
    }
    
    func registerHeaderFooterView(nibModel: AnyCollectionFactory.Type) {
        
        let id = String(describing: nibModel.wrappedType)
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: id)
    }
    
    func registerHeaderFooterView(classModels: [AnyCollectionFactory.Type]) {
        
        classModels.forEach {
            
            let id = String(describing: $0.wrappedType)
            register($0.wrappedType, forHeaderFooterViewReuseIdentifier: id)
        }
    }
    
    func registerHeaderFooterView(nibModels: [AnyCollectionFactory.Type]) {
        
        nibModels.forEach { registerHeaderFooterView(nibModel: $0) }
    }
    
}

extension UICollectionView {
    
    func dequeueReusableCell(withFactory factory: AnyCollectionFactory,
                             for indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = dequeueReusableCell(withReuseIdentifier: factory.identifier, for: indexPath)
        factory.setup(anyItem: cell)
        
        return cell
    }
    
    func register(nibModels: [AnyCollectionFactory.Type]) {
        
        nibModels.forEach {
            
            let id = String(describing: $0.wrappedType)
            let nib = UINib(nibName: id, bundle: nil)
            register(nib, forCellWithReuseIdentifier: id)
        }
    }
    
    func register(classes: [AnyCollectionFactory.Type]) {
        
        classes.forEach {
            
            let id = String(describing: $0.wrappedType)
            register($0.wrappedType, forCellWithReuseIdentifier: id)
        }
    }
    
    func register(nibModel: AnyCollectionFactory.Type) {
        
        register(nibModels: [nibModel])
    }
    
    func dequeueSupplementaryView(withFactory factory: AnyCollectionFactory,
                                  viewForSupplementaryElementOfKind kind: String,
                                  at indexPath: IndexPath) -> UICollectionReusableView {
        
        let supplementaryView = dequeueReusableSupplementaryView(ofKind: kind,
                                                                 withReuseIdentifier: factory.identifier,
                                                                 for: indexPath)
        factory.setup(anyItem: supplementaryView)
        return supplementaryView
    }
    
    func registerSupplementaryView(nibModel: AnyCollectionFactory.Type, for type: String) {
        
        let id = String(describing: nibModel.wrappedType)
        let nib = UINib(nibName: id, bundle: nil)
        register(nib, forSupplementaryViewOfKind: type, withReuseIdentifier: id)
    }
    
    func registerSupplementaryView(nibModels: [AnyCollectionFactory.Type], for type: String) {
        
        nibModels.forEach { registerSupplementaryView(nibModel: $0, for: type) }
    }
    
    func registerSupplementaryView(classes: [AnyCollectionFactory.Type], for type: String) {
        
        classes.forEach {
        
            register($0.wrappedType,
                     forSupplementaryViewOfKind: type,
                     withReuseIdentifier: String(describing: $0.wrappedType))
        }
    }
    
}
