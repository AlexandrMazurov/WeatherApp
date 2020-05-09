//
//  ForecastInfo.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

struct ForecastInfo: Decodable {
    let temperature: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        temperature = try container.decode(Double.self, forKey: .temperature)
        feelsLike = try container.decode(Double.self, forKey: .feelsLike)
        pressure = try container.decode(Int.self, forKey: .pressure)
        humidity = try container.decode(Int.self, forKey: .humidity)
    }
}
