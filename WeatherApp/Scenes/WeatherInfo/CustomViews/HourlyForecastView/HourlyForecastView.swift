//
//  HourlyForecastView.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

private enum Constants {
    static let hourForecastCellIdentifier = "HourForecastCell"
    static let todayString = "Today"
    static let collectionViewBorderRadius: CGFloat = 0.16
}

class HourlyForecastView: UIView, NibLoadable {
    
    @IBOutlet weak var hourlyForecastCollectionView: UICollectionView!
    @IBOutlet private weak var dayNameLabel: UILabel!
    @IBOutlet private weak var todayNameLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    
    func configure<T: UICollectionViewDelegate>(with weakForecast: WeakForecast?, delegateAndDataSourceOwner: T)
        where T: UICollectionViewDataSource {
            registerCells()
            hourlyForecastCollectionView.delegate = delegateAndDataSourceOwner
            hourlyForecastCollectionView.dataSource = delegateAndDataSourceOwner
            dayNameLabel.text = weakForecast?.dayName
            todayNameLabel.text = Constants.todayString
            minTemperatureLabel.text = weakForecast?.minTemperature.description
            maxTemperatureLabel.text = weakForecast?.maxTemperature.description
            hourlyForecastCollectionView.layer.borderColor = UIColor.white.cgColor
            hourlyForecastCollectionView.layer.borderWidth = Constants.collectionViewBorderRadius
            
    }
    
    func reloaData() {
        hourlyForecastCollectionView.reloadData()
    }
    
    private func registerCells() {
        hourlyForecastCollectionView?.register(UINib(nibName: Constants.hourForecastCellIdentifier,
                                                     bundle: Bundle.main),
                                               forCellWithReuseIdentifier: Constants.hourForecastCellIdentifier)
    }
}
