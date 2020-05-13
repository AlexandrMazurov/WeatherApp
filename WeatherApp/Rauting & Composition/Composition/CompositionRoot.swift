//
//  CompositionRoot.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

class CompositionRoot {
    
    weak var navigator: SceneNavigatorProtocol!
    
    private let api: ApiProtocol
    private let dateManager: DateManagerProtocol
    private let weatherManager: WeatherManagerProtocol
    private let localRepository: LocalRepositoryProtocol
    
    init(serviceFactory: ServiceFactoryProtocol) {
        self.api = serviceFactory.makeApi()
        self.dateManager = serviceFactory.makeDateManager()
        self.weatherManager = serviceFactory.makeWeatherManager()
        self.localRepository = serviceFactory.makeLocalRepository()
    }
    
    func composeScene(_ scene: Scene) -> UIViewController {
        switch scene {
        case .weatherInfo:
            return SceneFactory.makeWeatherInfo(weatherManager: weatherManager, localRepository: localRepository)
        }
    }
}
