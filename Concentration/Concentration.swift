//
//  MODEL
//  Concentration.swift
//  Concentration
//
//  Created by Mark Johnson on 6/17/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//
// Class is a REFERENCE type - passing pointers around, not copying
// Classes get a free init w/ no arguments as long as all vars are initialized
//

import Foundation

//Model of the Concentration game
struct Concentration {
    
//Variables
    private(set) var flipCount = 0
    private(set) var scoreCount = 0
    private(set) var cards = [Card]()
    private var indexOfSingleFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for searchIndex in cards.indices {
                if cards[searchIndex].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = searchIndex
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for flipDownIndex in cards.indices {
                cards[flipDownIndex].isFaceUp = (flipDownIndex == newValue)
            }
        }
    }

//Functions
    mutating func chooseCard(at index: Int){
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        if !cards[index].isMatched {                                                //Ignore all matched cards
            if let matchIndex = indexOfSingleFaceUpCard, matchIndex != index {      //Already one single card face up
                flipCount += 1                                                      //Flip count
                if cards[index].identifier == cards[matchIndex].identifier {        //Check if cards match
                    cards[index].isMatched = true                                   //Match code
                    cards[matchIndex].isMatched = true
                    scoreCount += 2
                }
                else{                                                               //Not a match
                    if cards[index].hasBeenMismatched { scoreCount -= 1 }
                    if cards[matchIndex].hasBeenMismatched { scoreCount -= 1 }
                    cards[index].hasBeenMismatched = true
                    cards[matchIndex].hasBeenMismatched = true
                }
                cards[index].isFaceUp = true
            }
            else {                                                                  //Either no cards or 2 cards are face up
                flipCount += 1                                                      //Flip count
                indexOfSingleFaceUpCard = index         //Index selected card
            }
        }
    }
    
//Initialization
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): numberOfPairsOfCards is <0")
        var shuffleOrder = [Int]()
        var newShuffleOrder = [Int]()
        let numberOfCards = numberOfPairsOfCards*2
        var tempCards = [Card]()
        
        Card.newCardSet()
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            //Assigning struct COPPIES it
            tempCards.append(card)
            tempCards.append(card)
        }
        
        //Randomize cards
        for index in 0..<numberOfCards {
            shuffleOrder.append(index)
        }
        
        for index in 0..<numberOfCards {
            newShuffleOrder.append(shuffleOrder.remove(at: (numberOfCards-index-1).arc4random))
        }
        
        for index in 0..<numberOfCards {
            cards.append(tempCards[newShuffleOrder[index]])
        }
        
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}
