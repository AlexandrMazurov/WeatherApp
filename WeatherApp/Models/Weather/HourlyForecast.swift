//
//  HourlyForecast.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/9/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class HourlyForecast {
    let time: String
    let imageName: String
    let degree: String
    
    init(time: String, imageName: String, degree: String) {
        self.time = time
        self.imageName = imageName
        self.degree = degree
    }
}
