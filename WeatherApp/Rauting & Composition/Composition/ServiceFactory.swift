//
//  ServiceFactory.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class ServiceFactory: ServiceFactoryProtocol {
    
    private let api: ApiProtocol
    private let dateManager: DateManagerProtocol
    private let locationManager: LocationManagerProtocol
    
    init(api: ApiProtocol,
         dateManager: DateManagerProtocol,
         locationManager: LocationManagerProtocol) {
        self.api = api
        self.dateManager = dateManager
        self.locationManager = locationManager
    }
    
    func makeApi() -> ApiProtocol {
        return api
    }
    
    func makeDateManager() -> DateManagerProtocol {
        return dateManager
    }
    
    func makeWeatherManager() -> WeatherManagerProtocol {
        return WeatherManager(api: api, dateManager: dateManager, locationManager: locationManager)
    }
    
    func makeLocalRepository() -> LocalRepositoryProtocol {
        return LocalRepository()
    }
    
    
}
