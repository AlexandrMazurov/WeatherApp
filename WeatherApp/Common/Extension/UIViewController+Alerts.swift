//
//  UIViewController+Alerts.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showOKAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = title

        let title = "Ok"
        alert.addAction(UIAlertAction(title: title, style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLocationSettingsAllert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.view.accessibilityIdentifier = title
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(settingsURL) else {
                return
            }
            UIApplication.shared.open(settingsURL)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
