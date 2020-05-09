//
//  URLEndpoint.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

public enum URLEndpoint {
    
    static let baseURL = "https://api.openweathermap.org/data/2.5/"
    static func getWeatherForecast(latitude: String, longitude: String, apiKey: String) -> String {
        return "\(baseURL)forecast?lat=\(latitude)&lon=\(longitude)&APPID=\(apiKey)"
    }
}
