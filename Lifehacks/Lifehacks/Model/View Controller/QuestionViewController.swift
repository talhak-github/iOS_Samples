//
//  QuestionViewController.swift
//  Lifehacks
//
//  Created by Talha Khalid on 3/30/20.
//  Copyright © 2020 TalhaKhalid. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, Stateful {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ownerImageView: UIImageView!
    @IBOutlet weak var ownerNameLabel: UILabel!
    
    var stateController: StateController?
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let question = question else{
            return
        }
        
        titleLabel.text = question.title
        bodyLabel.text = question.body
        scoreLabel.text = "\(question.score)"
        let owner = question.owner
        ownerImageView.image = UIImage(named: owner.profileImage)
        ownerNameLabel.text = owner.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if let profileViewController = segue.destination as? ProfileViewController{
            passState(to: profileViewController)
            profileViewController.user = question?.owner
        }
    }
    
    @IBAction func voteUp(_ sender: Any) {
        question?.voteUp()
        updateScore(for: question)
        updateState(for: question)
    }
    
    @IBAction func voteDown(_ sender: Any) {
        question?.voteDown()
        updateScore(for: question)
        updateState(for: question)
    }
    
}

private extension QuestionViewController {
    func updateState(for question: Question?) {
        if let question = question {
            stateController?.updateQuestion(question)
        }
    }
    
    func updateScore(for question: Question?) {
        scoreLabel.text = "\(question?.score ?? 0)"
    }
}

