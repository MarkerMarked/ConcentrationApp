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
class Concentration {
    
//Variables
    var cards = [Card]()
    var indexOfSingleFaceUpCard: Int?
    var flipCount = 0
    var scoreCount = 0
    
//Functions
    func chooseCard(at index: Int){
        if !cards[index].isMatched {    //Ignore all matched cards
            
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
                indexOfSingleFaceUpCard = nil
            }
                
            else {                      //Either no cards or 2 cards are face up
                flipCount += 1          //Flip count
                
                for flipDownIndex in cards.indices{         //Flip all face down
                    cards[flipDownIndex].isFaceUp = false
                }
                    cards[index].isFaceUp = true            //Flip selected face up
                    indexOfSingleFaceUpCard = index         //Index selected card
            }
        }
    }
    
//Initialization
    init(numberOfPairsOfCards: Int){
        
//Variables
        var shuffleOrder = [Int]()
        var newShuffleOrder = [Int]()
        let numberOfCards = numberOfPairsOfCards*2
        var tempCards = [Card]()
        
        Card.identifierFactory = 0
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
            let randomIndex = Int(arc4random_uniform(UInt32(numberOfCards - index - 1)))
            
            newShuffleOrder.append(shuffleOrder.remove(at: randomIndex))
        }
        
        for index in 0..<numberOfCards {
            cards.append(tempCards[newShuffleOrder[index]])
        }
        
    }
}
