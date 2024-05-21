//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Ivana Rast on 29.04.2024..
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("\(viewModel.getGameName())").font(.title)
            Text("Current score: \(viewModel.currentScore)")
            ScrollView {
                cards.animation(.default, value: viewModel.cards)
            }
            Button("New Game") {
                viewModel.startNewGame()
            }
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card, themeColor: viewModel.themeColor)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    let themeColor: Color
    
    init(_ card: MemoryGame<String>.Card, themeColor: Color) {
        self.card = card
        self.themeColor = themeColor
    }
    
    var body: some View {
        ZStack {
            let baseCard = RoundedRectangle(cornerRadius: 12)
            Group {
                baseCard.fill(.white)
                baseCard.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            baseCard.fill(themeColor).opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
