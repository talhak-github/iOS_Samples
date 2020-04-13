//
//  Question.swift
//  Lifehacks
//
//  Created by Talha Khalid on 3/30/20.
//  Copyright © 2020 TalhaKhalid. All rights reserved.
//

import Foundation

struct Question: Equatable, Decodable{
    let id: Int
    let title: String
    let body: String?
    private (set) var score: Int
    let owner: User?
    
    enum CodingKeys: String, CodingKey {
        case id = "question_id"
        case title
        case body
        case score
        case owner
    }
    
    mutating func voteUp(){
        score += 1
    }
    
    mutating func voteDown(){
        score -= 1
    }
}

extension Question {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return
            lhs.title == rhs.title &&
                lhs.body == rhs.body &&
                lhs.owner == rhs.owner
    }
}
