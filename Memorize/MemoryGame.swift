//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Ivana Rast on 07.05.2024..
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func choose(card: Card) {
        
    }
    
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
