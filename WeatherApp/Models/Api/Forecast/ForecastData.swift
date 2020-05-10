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
    let main: ForecastInfoData
    let weather: [WeatherInfoData]
    let wind: WindInfoData
    let timesOfDay: TimesOfDay
    
    enum CodingKeys: String, CodingKey {
        case time = "dt"
        case main = "main"
        case weather = "weather"
        case wind = "wind"
        case timesOfDay = "sys"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        time = try container.decode(Int.self, forKey: .time)
        main = try container.decode(ForecastInfoData.self, forKey: .main)
        weather = try container.decode([WeatherInfoData].self, forKey: .weather)
        wind = try container.decode(WindInfoData.self, forKey: .wind)
        timesOfDay = try container.decode(TimesOfDay.self, forKey: .timesOfDay)
    }
}
