//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Ivana Rast on 07.05.2024..
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var currentScore: Int
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        assert(numberOfPairsOfCards >= 2, "Min number of pairs is 2")
        
        cards = []
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex + 1)a"))
            cards.append(Card(content: content, id: "\(pairIndex + 1)b"))
        }
        cards.shuffle()
        
        currentScore = 0
    }
    
    var indexOfTheFaceUpCard: Int? {
        get { cards.indices.filter { index in cards[index].isFaceUp }.only }
        set { cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        scoreMatch()
                    } else {
                        if (cards[chosenIndex].isSeen) {
                            scoreMismatch()
                        }
                        if (cards[potentialMatchIndex].isSeen) {
                            scoreMismatch()
                        }
                        cards[chosenIndex].isSeen = true
                        cards[potentialMatchIndex].isSeen = true
                    }
                } else {
                    indexOfTheFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
        }
    }
    
    mutating func scoreMatch() -> Void {
        currentScore += 2
    }
    
    mutating func scoreMismatch() -> Void {
        currentScore -= 1
    }
    
    struct Card: Equatable, Identifiable, CustomStringConvertible {
        var isFaceUp = false
        var isMatched = false
        var isSeen = false
        let content: CardContent
        
        var id: String
        var description: String {
            "content = \(content) isFaceUp = \(isFaceUp)"
        }
    }
    
    func getCurrentScore() -> Int {
        return currentScore
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
