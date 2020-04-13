//
//  UsersWrapper.swift
//  Lifehacks
//
//  Created by Talha Khalid on 4/13/20.
//  Copyright © 2020 TalhaKhalid. All rights reserved.
//

import Foundation

struct Wrapper<ModelType: Decodable>: Decodable {
    let items: [ModelType]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}
