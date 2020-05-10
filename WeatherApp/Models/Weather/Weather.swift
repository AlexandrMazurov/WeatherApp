//
//  Weather.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class Weather {
    let cityName: String
    let degree: Int16
    let situation: String
    let hourlyForecast: [HourlyForecast]
    let weakForecast: [WeakForecast]
    let weatherInfo: [WeatherInfo]
    
    init(cityName: String,
         degree: Int16,
         situation: String,
         hourlyForecast: [HourlyForecast],
         weakForecast: [WeakForecast],
         weatherInfo: [WeatherInfo]) {
        self.cityName = cityName
        self.degree = degree
        self.situation = situation
        self.hourlyForecast = hourlyForecast
        self.weakForecast = weakForecast
        self.weatherInfo = weatherInfo
    }
}
