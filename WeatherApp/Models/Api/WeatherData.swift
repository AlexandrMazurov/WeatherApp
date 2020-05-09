//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let list: [ForecastData]
    let city: CityData
}
