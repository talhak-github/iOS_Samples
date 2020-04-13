//
//  QuestionCell.swift
//  Lifehacks
//
//  Created by Talha Khalid on 4/12/20.
//  Copyright © 2020 TalhaKhalid. All rights reserved.
//

import Foundation
import UIKit

class QuestionCell: UITableViewCell{
    
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var ownerLabel: UILabel!
    
    var score: Int?{
        didSet{
            scoreLabel.text = "\(score ?? 0)"
        }
    }
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var username: String? {
        didSet {
            ownerLabel.text = "Asked by: " + (username ?? "")
        }
    }
    
}
