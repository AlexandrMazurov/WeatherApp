//
//  CityData.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

struct CityData: Decodable {
    let name: String
    let sunRise: Int
    let sunSet: Int
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case sunRise = "sunrise"
        case sunSet = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        sunRise = try container.decode(Int.self, forKey: .sunRise)
        sunSet = try container.decode(Int.self, forKey: .sunSet)
    }
}
