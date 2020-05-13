//
//  WeatherInfo+SceneFactory.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

extension SceneFactory {
    static func makeWeatherInfo(weatherManager: WeatherManagerProtocol,
                                localRepository: LocalRepositoryProtocol) -> WeatherInfoViewController {
        let viewController: WeatherInfoViewController = WeatherInfoViewController.storyboardInstance()
        viewController.presenter = WeatherInfoPresenter(view: viewController,
                                                        weatherManager: weatherManager,
                                                        localRepository: localRepository)
        return viewController
    }
}
