//
//  MainTabBarController.swift
//  Lifehacks
//
//  Created by Talha Khalid on 4/11/20.
//  Copyright © 2020 TalhaKhalid. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController, Stateful{
    
    var stateController: StateController?
    
    override func viewDidLoad() {
        guard let viewControllers = viewControllers else {
            return
        }
        for case let navigationController as UINavigationController in viewControllers {
            if let rootViewController = navigationController.viewControllers.first as? Stateful {
                passState(to: rootViewController)
            }
        }
    }
    
}
