//
//  NibLoadable.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

protocol NibLoadable {
    func loadFromNib()
}

extension NibLoadable where Self: UIView {
    func loadFromNib() {
        let viewType = type(of: self)
        let viewName = String(describing: viewType)
        let bundle = Bundle(for: viewType)
        let nib = UINib(nibName: viewName, bundle: bundle)
        if let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
        }
    }
}
