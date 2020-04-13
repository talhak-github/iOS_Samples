//
//  URL.swift
//  Lifehacks
//
//  Created by Talha Khalid on 4/13/20.
//  Copyright © 2020 TalhaKhalid. All rights reserved.
//

import Foundation

extension URL {
    func appendingParameters(_ parameters: [String: String]) -> URL {
        var urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        var queryItems = urlComponents.queryItems ?? []
        for key in parameters.keys {
            queryItems.append(URLQueryItem(name: key, value: parameters[key]))
        }
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
