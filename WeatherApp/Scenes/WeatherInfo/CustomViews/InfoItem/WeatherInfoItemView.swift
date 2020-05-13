//
//  WeatherInfoItem.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

class WeatherInfoItemView: UIView, NibLoadable {
    
    @IBOutlet private weak var parameterValueNameLabel: UILabel!
    @IBOutlet private weak var parameterValueLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    
    func configure(with info: WeatherInfo?) {
        self.parameterValueNameLabel.text = info?.name.uppercased()
        self.parameterValueLabel.text = info?.value
    }
}
