//
//  LocationManagerProtocol.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/10/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

protocol LocationManagerProtocol {
    var latitude: String? { get }
    var longitude: String? { get }
}
