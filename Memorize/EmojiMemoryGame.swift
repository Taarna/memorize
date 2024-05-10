//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Ivana Rast on 07.05.2024..
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    @Published private var model: MemoryGame<String>
    
    private var currentTheme: Theme
    
    init() {
        self.currentTheme = Themes.randomTheme()
        self.model = EmojiMemoryGame.createMemoryGame(with: self.currentTheme)
    }
    
    private static func createMemoryGame(with theme: Theme) -> MemoryGame<String> {
        let randomEmojis = theme.emojis.shuffled()
        let numberOfPairs = randomEmojis.count > theme.numberOfPairs ? theme.numberOfPairs : randomEmojis.count
        
        return MemoryGame(numberOfPairsOfCards: numberOfPairs) { pairIndex in
            if randomEmojis.indices.contains(pairIndex) {
                return randomEmojis[pairIndex]
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
        model = EmojiMemoryGame.createMemoryGame(with: Themes.randomTheme())
    }
}
