//
//  WRefreshControl.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

import UIKit

class WRefreshControl: UIRefreshControl {
    
    // MARK: - Public properties
    
    var isVisible: Bool = false {
        
        didSet {
            
            if isVisible {
                
                forcedBeginRefreshing()
            }
            else {
                
                endRefreshing()
            }
        }
    }
    
}

// MARK: - UIRefreshControl + Forced refresh
extension UIRefreshControl {
    
    func forcedBeginRefreshing() {
        
        guard !isRefreshing else { return }
        beginRefreshing()
        guard let scrollView = superview as? UIScrollView,
              scrollView.contentOffset.y >= 0 else { return }
        scrollView.setContentOffset(CGPoint(x: 0, y: -max(bounds.height, 28)), animated: true)
    }
    
}
