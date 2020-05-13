//
//  WeatherInfoCell.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

class WeatherInfoCell: UITableViewCell {
    
    @IBOutlet private weak var weatherInfoStackView: UIStackView!
    
    func configure(with info: [WeatherInfo?]) {
        weatherInfoStackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        info.forEach {
            let infoView = WeatherInfoItemView()
            infoView.configure(with: $0)
            weatherInfoStackView.addArrangedSubview(infoView)
        }
    }
}
