//
//  ApiProtocol.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

protocol ApiProtocol {
    func getWeatherForecast(lat: String, lon: String, completion: @escaping (Result<WeatherData, Error>) -> Void)
}
