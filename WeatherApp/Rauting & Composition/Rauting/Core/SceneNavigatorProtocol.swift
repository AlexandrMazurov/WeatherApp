//
//  SceneNavigatorProtocol.swift
//  WeatherApp
//
//  Created by Mazurov, Aleksandr on 5/13/20.
//  Copyright © 2020 Mazurov, Aleksandr. All rights reserved.
//

import UIKit

protocol SceneNavigatorProtocol: class {
    func initViewControllerHierarchy(withRootScene rootScene: Scene)
    func navigateTo(_ scene: Scene, transitionType: SceneTransitionType)
}

protocol SceneNavigatorFlowProtocol: SceneNavigatorProtocol {
    var currentViewController: UIViewController! { get }
}
