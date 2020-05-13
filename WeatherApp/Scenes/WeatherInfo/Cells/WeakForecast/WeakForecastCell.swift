//
//  WeakForecastCell.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

class WeakForecastCell: UITableViewCell {
    
    @IBOutlet private weak var dayNameLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    
    func configure(with forecast: WeakForecast?) {
        self.dayNameLabel.text = forecast?.dayName
        self.weatherImageView.image = UIImage(named: forecast?.imageName ?? "")
        self.maxTemperatureLabel.text = forecast?.maxTemperature.description
        self.minTemperatureLabel.text = forecast?.minTemperature.description
    }
}
