//
//  ApplicationFlow.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

class ApplicationFlow: FlowProtocol {
    
    private let window: UIWindow
    private let compositionRoot: CompositionRoot
    private let navigator: SceneNavigatorFlowProtocol
    private let flowRouter: ApplicationFlowRouter
    
    init(compositionRoot: CompositionRoot, window: UIWindow) {
        self.window = window
        self.compositionRoot = compositionRoot
        self.navigator = SceneNavigator(window: window, compositionRoot: compositionRoot)
        self.flowRouter = ApplicationFlowRouter(navigator: navigator)
        self.compositionRoot.navigator = navigator
    }
    
    func start(transitionType: SceneTransitionType) {
        let mainFlowCoordinator = makeMainFlow()
        flowRouter.start(flow: mainFlowCoordinator, transitionType: transitionType)
    }
    
    private func makeMainFlow() -> MainFlow {
        return MainFlow(navigator: navigator)
    }
}
