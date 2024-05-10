//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ivana Rast on 07.05.2024..
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
    
    init() {
        self.model = EmojiMemoryGame.createMemoryGame()
    }
    
    private static func createMemoryGame() -> MemoryGame<String> {
        let theme = GameThemes().random()
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.emojis.indices.contains(pairIndex) {
                return theme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
