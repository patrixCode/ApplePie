//
//  ViewController.swift
//  ApplePie
//
//  Created by Patrik Seben on 08/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = ["mikulas", "teddy", "vyhodil", "srdce", "farkas", "bublina", "ponorka", "red", "green"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }

    
    @IBOutlet var treeImageView: UIImageView!
    
    @IBOutlet var correctWordLabel: UILabel!
    
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
    }
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
        let newWord = listOfWords.removeFirst()
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
        updateUI()
        enableLetterButtons(true)
        } else {
            enableLetterButtons(false)
            
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = currentGame.formattedWord
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }

    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateUI()
        updateGameState()
    }
    func updateGameState(){
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
        
    }
    
    
    
    
    
}
    


