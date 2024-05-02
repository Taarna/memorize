//
//  ContentView.swift
//  Memorize
//
//  Created by Ivana Rast on 29.04.2024..
//

import SwiftUI

struct ContentView: View {
    let emojisChristmas = ["🎄", "🎅", "❄️", "⛄️", "⛷️", "🌟", "🔔", "🦌", "🍾", "⛪️", "🦃", "🥳"]
    let emojisHalloween = ["🎃", "👻", "🕸️", "👿", "🧟‍♀️", "💀", "😱", "👹", "🧙", "🍬", "🕷️", "🦇"]
    let emojisAnimals = ["🐮", "🐶", "🐱", "🦆", "🐵", "🦊", "🐸", "🦋", "🐢", "🪱", "🐌", "🐙"]
    
    @State var emojis: [String] = []
    @State var cardCount: Int = 0
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
            Spacer()
            themeChangers
        }
        .padding()
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        return cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
    var cardAdder: some View {
        return cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var themeChangers: some View {
        HStack(alignment: .center) {
            themeChanger(to: "Xmas")
            themeChanger(to: "Halloween")
            themeChanger(to: "Animals")
        }
    }
    
    func themeChanger(to themeName: String) -> some View {
        Button(action: {
            changeTheme(to: themeName)
        }, label: {
            Text(themeName)
        })
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .border(.black)
        .cornerRadius(3)
    }
    
    func changeTheme(to themeName: String) {
        emojis = switch themeName {
        case "Xmas" :
            emojisChristmas
        case "Halloween":
            emojisHalloween
        case "Animals":
            emojisAnimals
        default:
            emojisAnimals
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let baseCard = RoundedRectangle(cornerRadius: 12)
            Group {
                baseCard.fill(.white)
                baseCard.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            baseCard.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
