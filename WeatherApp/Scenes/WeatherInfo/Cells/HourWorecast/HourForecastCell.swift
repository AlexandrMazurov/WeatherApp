//
//  HourForecastCellCell.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

class HourForecastCell: UICollectionViewCell {
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var weatherImageView: UIImageView!
    @IBOutlet private weak var temperatureLabel: UILabel!
    
    func configure(with forecast: HourlyForecast?) {
        self.timeLabel.text = forecast?.time
        self.weatherImageView.image = UIImage(named: forecast?.imageName ?? "")
        self.temperatureLabel.text = forecast?.degree
    }
}
