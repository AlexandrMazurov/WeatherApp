//
//  SceneDelegate+CompositionRootFactory.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

extension SceneDelegate {
    
    func makeCompositionRoot() -> CompositionRoot {
        let factory = ServiceFactory(api: OpenWeatherMapApi(),
                                     dateManager: DateManager(),
                                     locationManager: LocationManager())
        return CompositionRoot(serviceFactory: factory)
    }
}
