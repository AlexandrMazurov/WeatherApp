//
//  LocalRepositoryProtocol.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

protocol LocalRepositoryProtocol {
    func getCurrentLocationWeather() -> Weather?
    func saveCurrenLocationWeather(weather: Weather)
}
