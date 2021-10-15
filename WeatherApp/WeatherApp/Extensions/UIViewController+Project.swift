//
//  UIViewController+Project.swift
//  WeatherApp
//
//  Created by Georgy Gorbenko on 15.10.2021.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(with message: String?) {
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        guard view.window != nil else { return }
        showAlert(title: "Error",
                  message: message,
                  actions: [okAction],
                  forceCancel: false)
    }
    
    func showAlert(title: String?, message: String?) {
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default,
                                     handler: nil)
        showAlert(title: title, message: message, actions: [okAction])
    }
    
    func showAlert(title: String?,
                   message: String?,
                   actions: [UIAlertAction]) {
        
        showAlert(title: title, message: message, actions: actions, forceCancel: true)
    }
    
    func showAlert(title: String?, message: String?, actions: [UIAlertAction], forceCancel: Bool) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        actions.forEach { alertController.addAction($0) }
        if forceCancel, !actions.contains(where: { $0.style == .cancel }) {
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        alertController.modalPresentationStyle = .fullScreen
        present(alertController, animated: true, completion: nil)
    }
    
    func showActionShit(message: String?, actions: [UIAlertAction]) {
        
        showActionShit(title: nil, message: message, actions: actions)
    }
    
    func showActionShit(title: String?, message: String?, actions: [UIAlertAction]) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .actionSheet)
        if !actions.contains(where: { $0.style == .cancel }) {
            
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        actions.forEach { alertController.addAction($0) }
        present(alertController, animated: true, completion: nil)
    }
    
    func showShare(items: [Any]) {
        
        let viewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        present(viewController, animated: true)
    }
    
}
