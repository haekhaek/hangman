//
//  ViewController.swift
//  hangman2
//
//  Created by Eugen Bopp on 13/01/2017.
//  Copyright © 2017 Eugen Bopp. All rights reserved.
//

import UIKit

enum QuestionType {
    case open
    case closed
}

class Quiz {
    var question: String
    var answer: String
    var type: QuestionType
    
    init(question: String, answer: String, type: QuestionType) {
        self.question = question
        self.answer = answer
        self.type = type
    }
}

class ClosedQuiz: Quiz {
    var answers: [String]
    
    init(question: String, answer: String, type: QuestionType, answers: [String]) {
        self.answers = answers
        super.init(question: question, answer: answer, type: type)
    }
}

class ViewController: UIViewController {
    let hangingMan = ["HM-1.png", "HM-2.png", "HM-3.png", "HM-4.png", "HM-5.png", "HM-6.png", "HM-7.png", "HM-8.png", "HM-9.png", "HM-10.png"]
    let hangingMangAnimation = ["HM5-0.png", "HM5-1.png", "HM5-2.png", "HM5-3.png", "HM5-4.png", "HM5-5.png", "HM5-6.png", "HM5-7.png"]
    let hangingTree = ["HM3-1.jpg", "HM3-2.jpg", "HM3-3.jpg", "HM3-4.jpg", "HM4-5.jpg"]
    var indexBody = 0
    var indexTree = 0
    var myGameData: [Quiz]!
    var myQuiz: Quiz!
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var rightBtnClicked: UIButton!
    @IBOutlet weak var bodyImageView: UIImageView!
    @IBOutlet weak var myInputField: UITextField!
    @IBOutlet weak var questionLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myInputField.becomeFirstResponder()
        myGameData = generateQuiz()
        myQuiz = myGameData.popLast()!
        questionLabel.text = myQuiz.question
    }

    func generateQuiz() -> [Quiz] {
        var myGameData = [Quiz]()
        myGameData.append(Quiz(question: "HTTP stands for?", answer: "hyper text transfer protocol", type: QuestionType.open))
        myGameData.append(Quiz(question: "SMTP stands for?", answer: "simple mail transfer protocol", type: QuestionType.open))
        myGameData.append(Quiz(question: "How many bit's uses IPv4 for addresses?", answer: "32", type: QuestionType.open))
        myGameData.append(Quiz(question: "How many bit's uses IPv6 for addresses?", answer: "128", type: QuestionType.open))
        myGameData.append(Quiz(question: "What does NAT stands for?", answer: "network address translation", type: QuestionType.open))
        return myGameData
    }
    
    func animateMe(imageToAnimate: UIImageView, images: [UIImage]){
        imageToAnimate.animationImages = images
        imageToAnimate.animationDuration = 2.0
        imageToAnimate.startAnimating()
    }
    
    func resetGame () {
        indexBody = 0
        indexTree = 0
        imageOne.stopAnimating()
        imageOne.image = nil
        bodyImageView.stopAnimating()
        bodyImageView.image = nil
        rightBtnClicked.isEnabled = true
        myInputField.isEnabled = true
        myInputField.becomeFirstResponder()
        
        myGameData = generateQuiz()
    }

    @IBAction func leftBtnClicked(_ sender: Any) {
        resetGame()
    }

    @IBAction func rightBtnClicked(_ sender: Any) {
        let myString = self.myInputField.text?.lowercased()
        var foo: [String]?
        var bar: String
        
        foo = myString!.components(separatedBy: .whitespacesAndNewlines).filter{!$0.isEmpty}
        bar = (foo?.joined(separator: " "))!

        if bar != myQuiz.answer {
            if indexTree < hangingTree.count {
                let images = [UIImage(named: hangingTree[indexTree])!]
                animateMe(imageToAnimate: imageOne, images: images)
                indexTree += 1

            } else if indexBody < hangingMan.count {
                let images = [UIImage(named: hangingMan[indexBody])!]
                animateMe(imageToAnimate: bodyImageView, images: images)
                indexBody += 1

            } else {
                rightBtnClicked.isEnabled = false
                var images = [UIImage]()
                for i in 0..<hangingMangAnimation.count {
                    images.append(UIImage(named: hangingMangAnimation[i])!)
                }
                animateMe(imageToAnimate: bodyImageView, images: images)
                myInputField.isEnabled = false
            }
        } else {
            if myGameData.count == 0 {
                resetGame()
            }else{
                myQuiz = myGameData.popLast()
                questionLabel.text = myQuiz.question
                myInputField.text = ""
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

