//
//  WeakForecast.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class WeakForecast {
    let dayName: String
    let imageName: String
    let minTemperature: Int16
    let maxTemperature: Int16
    
    init(dayName: String,
         imageName: String,
         minTemperature: Int16,
         maxTemperature: Int16) {
        self.dayName = dayName
        self.imageName = imageName
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
    }
}
