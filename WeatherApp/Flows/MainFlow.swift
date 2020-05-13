//
//  MainFlow.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import Foundation

class MainFlow: FlowProtocol {
    
    private unowned let navigator: SceneNavigatorProtocol
    
    init(navigator: SceneNavigatorProtocol) {
        self.navigator = navigator
    }
    
    func start(transitionType: SceneTransitionType) {
        navigator.initViewControllerHierarchy(withRootScene: .weatherInfo)
    }
    
    
}
