//
//  WeatherInfo.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/8/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

struct WeatherInfoData: Decodable {
    let mainInfo: String
    let description: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case mainInfo = "main"
        case description = "description"
        case icon = "icon"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        mainInfo = try container.decode(String.self, forKey: .mainInfo)
        description = try container.decode(String.self, forKey: .description)
        icon = try container.decode(String.self, forKey: .icon)
    }
}
