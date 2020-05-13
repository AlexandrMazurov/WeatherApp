//
//  UIViewController+Storyboard.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func storyboardInstance<T>() -> T {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController()
        
        guard let resViewController = viewController as? T else {
            fatalError("Cannot load view controller from storyboard")
        }
        
        return resViewController
    }
}
