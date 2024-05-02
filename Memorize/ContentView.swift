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
        static let icon = "snowflake"
        static let color: Color = .blue
    }
    enum HalloweenTheme {
        static let name = "Halloween"
        static let icon = "theatermasks.fill"
        static let color: Color = .orange
    }
    enum AnimalsTheme {
        static let name = "Animals"
        static let icon = "pawprint.fill"
        static let color: Color = .green
    }
}


struct ContentView: View {
    let emojisChristmas = ["🎄", "🎅", "❄️", "⛄️"]
    let emojisHalloween = ["🎃", "👻", "🕸️", "👿", "🧟‍♀️"]
    let emojisAnimals = ["🐮", "🐶", "🐱", "🦆", "🐵", "🦊"]
    
    @State var currentEmojis: [String] = []
    @State var currentColor: Color = .green
    
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
        .foregroundColor(currentColor)
    }
    
    var themeChangers: some View {
        HStack(alignment: .bottom) {
            ThemeButton(
                text: Themes.ChristmasTheme.name,
                imageName: Themes.ChristmasTheme.icon) { apply(theme: Themes.ChristmasTheme.name) }
            ThemeButton(
                text: Themes.HalloweenTheme.name,
                imageName: Themes.HalloweenTheme.icon) { apply(theme: Themes.HalloweenTheme.name) }
            ThemeButton(
                text: Themes.AnimalsTheme.name,
                imageName: Themes.AnimalsTheme.icon) { apply(theme: Themes.AnimalsTheme.name) }
        }
    }
    
    struct ThemeButton: View {
        var text: String
        var imageName: String
        var action: () -> Void
        
        var body: some View {
            Button(action: {
                action()
            }, label: {
                VStack {
                    Image(systemName: imageName)
                    Text(text).font(.caption)
                }
            })
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        }
    }
    
    func apply(theme: String) {
        switch theme {
        case Themes.ChristmasTheme.name :
            currentEmojis = emojisChristmas + emojisChristmas
            currentColor = Themes.ChristmasTheme.color
        case Themes.HalloweenTheme.name:
            currentEmojis = emojisHalloween + emojisHalloween
            currentColor = Themes.HalloweenTheme.color
        case Themes.AnimalsTheme.name:
            currentEmojis = emojisAnimals + emojisAnimals
            currentColor = Themes.AnimalsTheme.color
        default:
            currentEmojis = emojisAnimals + emojisAnimals
            currentColor = Themes.AnimalsTheme.color
        }
        currentEmojis.shuffle()
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
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
