//
//  ForecastData.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

struct ForecastData: Decodable {
    let time: Int
    let main: ForecastInfo
    let weather: [WeatherInfo]
    let wind: WindInfo
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case main = "main"
        case weather = "weather"
        case wind = "wind"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        time = try container.decode(Int.self, forKey: .time)
        main = try container.decode(ForecastInfo.self, forKey: .main)
        weather = try container.decode([WeatherInfo].self, forKey: .weather)
        wind = try container.decode(WindInfo.self, forKey: .wind)
    }
}
