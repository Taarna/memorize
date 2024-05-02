//
//  ContentView.swift
//  Memorize
//
//  Created by Ivana Rast on 29.04.2024..
//

import SwiftUI

enum Themes {
    enum ChristmasTheme {
        static let name = "Xmas"
    }
    enum HalloweenTheme {
        static let name = "Halloween"
    }
    enum AnimalsTheme {
        static let name = "Animals"
    }
}


struct ContentView: View {
    let emojisChristmas = ["🎄", "🎅", "❄️", "⛄️"]
    let emojisHalloween = ["🎃", "👻", "🕸️", "👿", "🧟‍♀️"]
    let emojisAnimals = ["🐮", "🐶", "🐱", "🦆", "🐵", "🦊"]
    
    @State var currentEmojis: [String] = []
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeChangers
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
            ForEach(0..<currentEmojis.count, id: \.self) { index in
                CardView(content: currentEmojis[index]).aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var themeChangers: some View {
        HStack(alignment: .center) {
            ThemeButton(theme: Themes.ChristmasTheme.name) { apply(theme: Themes.ChristmasTheme.name)}
            ThemeButton(theme: Themes.HalloweenTheme.name) { apply(theme: Themes.HalloweenTheme.name)}
            ThemeButton(theme: Themes.AnimalsTheme.name) { apply(theme: Themes.AnimalsTheme.name)}
        }
    }
    
    struct ThemeButton: View {
        var theme: String
        var action: () -> Void
        
        var body: some View {
            Button(action: {
                action()
            }, label: {
                Text(theme)
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .border(.black)}
    }
    
    func apply(theme: String) {
        currentEmojis = switch theme {
        case Themes.ChristmasTheme.name :
            emojisChristmas + emojisChristmas
        case Themes.HalloweenTheme.name:
            emojisHalloween + emojisHalloween
        case Themes.AnimalsTheme.name:
            emojisAnimals + emojisAnimals
        default:
            emojisAnimals + emojisAnimals
        }
        currentEmojis.shuffle()
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
