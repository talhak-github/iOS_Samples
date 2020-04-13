//
//  Stateful.swift
//  Lifehacks
//
//  Created by Talha Khalid on 4/10/20.
//  Copyright © 2020 TalhaKhalid. All rights reserved.
//

import Foundation

protocol Stateful: class {
    var stateController: StateController? { get set }
}

extension Stateful{
    func passState(to destination: Stateful){
        destination.stateController = stateController
    }
}
