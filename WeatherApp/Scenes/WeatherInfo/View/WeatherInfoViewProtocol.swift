//
//  WeatherInfoViewProtocol.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/12/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

protocol WeatherInfoViewProtocol: class {
    func reloadData(with weather: Weather?)
}
