//
//  User.swift
//  Lifehacks
//
//  Created by Talha Khalid on 3/30/20.
//  Copyright © 2020 TalhaKhalid. All rights reserved.
//

import Foundation

struct User: Equatable, Codable{
    let name: String
    let aboutMe: String?
    let profileImageURL: URL?
    let reputation: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name = "display_name"
        case aboutMe = "about_me"
        case profileImageURL = "profile_image"
        case reputation
    }
}


