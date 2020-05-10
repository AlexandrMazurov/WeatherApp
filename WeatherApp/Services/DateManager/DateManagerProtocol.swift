//
//  DateManagerProtocol.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/10/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

protocol DateManagerProtocol {
    func getDefaultTimeFormat(from timeInterval: TimeInterval) -> String
    func getHourTimeFormat(from timeInterval: TimeInterval) -> String
    func getDayName(from timeInterval: TimeInterval) -> String
}
