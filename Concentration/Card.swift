//
//  Card.swift
//  Concentration
//
//  Created by Mark Johnson on 6/17/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//
// Struct is a VALUE type - coppied when assigned/passed (Copy on Write, still efficient)
// Struct gets a free init w/ all of the vars, even if vars are initialized
//

import Foundation

struct Card{
    
    var isFaceUp = false
    var isMatched = false
    var hasBeenMismatched = false
    var identifier: Int
    
    
//Static is stored with TYPE not each OBJECT
    static var identifierFactory = 0
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory-1
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
