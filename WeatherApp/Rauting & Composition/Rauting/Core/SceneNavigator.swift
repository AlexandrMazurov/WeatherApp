//
//  SceneNavigator.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

class SceneNavigator: SceneNavigatorFlowProtocol {

    var currentViewController: UIViewController!
    private let compositionRoot: CompositionRoot
    private let window: UIWindow
    
    required init(window: UIWindow, compositionRoot: CompositionRoot) {
        self.window = window
        self.compositionRoot = compositionRoot
    }
    
    func initViewControllerHierarchy(withRootScene rootScene: Scene) {
        let viewController = compositionRoot.composeScene(rootScene)
        currentViewController = actualViewController(for: viewController)
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func navigateTo(_ scene: Scene, transitionType: SceneTransitionType) {
        let viewController = compositionRoot.composeScene(scene)
        
        switch transitionType {
        case .root:
            replaceRootWith(viewController)
        }
    }
    
    private func replaceRootWith(_ targetViewController: UIViewController) {
        currentViewController = actualViewController(for: targetViewController)
        window.set(rootViewController: targetViewController)
    }
    
    private func actualViewController(for viewController: UIViewController) -> UIViewController {
        if let navigationController = viewController as? UINavigationController {
            guard let firstViewController = navigationController.viewControllers.first else {
                fatalError("NavigationController is expected to have at least one View Controller")
            }
            return firstViewController
        } else {
            return viewController
        }
    }
    
}
