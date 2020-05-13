//
//  ServiceFactoryProtocol.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

protocol ServiceFactoryProtocol {
    func makeApi() -> ApiProtocol
    func makeDateManager() -> DateManagerProtocol
    func makeWeatherManager() -> WeatherManagerProtocol
    func makeLocalRepository() -> LocalRepositoryProtocol
}
