//
//  WeatherInfoPresenterProtocol.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

protocol WeatherInfoPresenterProtocol {
    func handleViewDidLoad()
    func numberOfHourForecasts() -> Int
    func hourForecast(for indexPath: IndexPath) -> HourlyForecast?
    func weakForecast(for indexPath: IndexPath) -> WeakForecast?
    func weatherInfo(for indexPath: IndexPath) -> [WeatherInfo?]
    func numberOfInfoRows() -> Int
    func weakForecastRange() -> ClosedRange<Int>
    func weatherInfoRange() -> ClosedRange<Int>
}
