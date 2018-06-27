//
//  Theme.swift
//  Concentration
//
//  Created by Mark Johnson on 6/26/18.
//  Copyright © 2018 Mark Johnson. All rights reserved.
//

import Foundation

struct Theme {
    var emojis = [Character]()
    
    static var selectedTheme = 0
    private(set) static var numberOfThemes = 0
    
    static func pickRandomTheme() {
        selectedTheme = Int(arc4random_uniform(UInt32(numberOfThemes)))
    }
    
    init(emojis inputEmojis: [Character]) {
        self.emojis = inputEmojis
        Theme.numberOfThemes += 1
        Theme.pickRandomTheme()
        
    }
}
