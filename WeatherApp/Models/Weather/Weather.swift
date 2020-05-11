//
//  Weather.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class Weather {
    let isCurrentLocation: Bool
    let cityName: String
    let degree: Int16
    let situation: String
    let hourlyForecast: [HourlyForecast]
    let weakForecast: [WeakForecast]
    let weatherInfo: [WeatherInfo]
    
    init(isCurrentLocation: Bool,
         cityName: String,
         degree: Int16,
         situation: String,
         hourlyForecast: [HourlyForecast],
         weakForecast: [WeakForecast],
         weatherInfo: [WeatherInfo]) {
        self.isCurrentLocation = isCurrentLocation
        self.cityName = cityName
        self.degree = degree
        self.situation = situation
        self.hourlyForecast = hourlyForecast
        self.weakForecast = weakForecast
        self.weatherInfo = weatherInfo
    }
    
    init(managedWeather: WeatherManagedObject) {
        self.isCurrentLocation = managedWeather.isCurrentLocation?.boolValue ?? false
        self.cityName = managedWeather.cityName ?? ""
        self.degree = managedWeather.degree
        self.situation = managedWeather.situation ?? ""
        self.hourlyForecast = managedWeather.hourlyForecast?.compactMap {
            guard let forecast = $0 as? HourlyForecastManagedObject else {
                return nil
            }
            return HourlyForecast(managedForecast: forecast)
        } ?? []
        self.weakForecast = managedWeather.weakForecast?.compactMap {
            guard let forecast = $0 as? WeakForecastManagedObject else {
                return nil
            }
            return WeakForecast(managedForecast: forecast)
            } ?? []
        self.weatherInfo = managedWeather.weatherInfo?.compactMap {
            guard let info = $0 as? WeatherInfoManagedObject else {
                return nil
            }
            return WeatherInfo(managedInfo: info)
            } ?? []
    }
}
