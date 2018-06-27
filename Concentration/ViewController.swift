//
//  CONTROLLER
//  ViewController.swift
//  Concentration
//
//  Created by Mark Johnson on 6/17/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
//
//VARIABLES
//
    private(set) var scoreCount = 0 {
        didSet {
            scoreLabel.text = "Score: \(scoreCount)"
        }
    }
    
    var numberOfPairsOfCards: Int {
           return (cardButtons.count+1)/2
    }
    
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    private var emojiSelection = [Int:Character]()
    let emojiThemeDict: [Int:Theme] = [0:Theme(emojis: ["💵","📈","📉","💰","💸","🏆","🤑","💎"]),
                                       1:Theme(emojis: ["📱","💻","☎️","📷","🎙","🔋","📡","🔭"]),
                                       2:Theme(emojis: ["❤️","🧡","💛","💚","💙","💜","🖤","💔"]),
                                       3:Theme(emojis: ["🇨🇦","🇺🇸","🇬🇧","🇰🇷","🇨🇳","🇩🇪","🇯🇵","🇺🇦"]),
                                       4:Theme(emojis: ["😇","😍","🤓","😎","😭","😱","🤮","🤕"]),
                                       5:Theme(emojis: ["👽","💩","😈","👺","👾","☠️","🤖","☃️"])
                                       ]
    
//
//FUNCTIONS
//
    
    //Press New Game Button
    @IBAction private func pressNewGame(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        //Chose a new game theme
        Theme.pickRandomTheme()
        emojiSelection = [:]
        updateViewFromModel()
    }
    
    //Press one Card
    @IBAction private func pressCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    //Update overall view
    private func updateViewFromModel(){
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                let emojiSelected = String(emoji(for: card))
                button.setTitle(emojiSelected, for: UIControlState.normal)                
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }
            else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.1723861568, blue: 0.07909288138, alpha: 0) : #colorLiteral(red: 1, green: 0.1723861568, blue: 0.07909288138, alpha: 1)
            }
        }
        
        //Update score and flips
        flipLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.scoreCount)"
    }
    
    //Pick Emoji for each card pair
    private func emoji(for card: Card) -> Character {
        
        //Pull selected theme String
        let themeIndex = Theme.selectedTheme
        if let selectedTheme  = emojiThemeDict[themeIndex] {
            if emojiSelection[card.identifier] == nil {
                emojiSelection[card.identifier] = selectedTheme.emojis[card.identifier]
            }
        }
        return emojiSelection[card.identifier] ?? "?"
    }

}

