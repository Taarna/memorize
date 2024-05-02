//
//  ContentView.swift
//  Memorize
//
//  Created by Ivana Rast on 29.04.2024..
//

import SwiftUI

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
        currentEmojis = switch themeName {
        case "Xmas" :
            emojisChristmas + emojisChristmas
        case "Halloween":
            emojisHalloween + emojisHalloween
        case "Animals":
            emojisAnimals + emojisAnimals
        default:
            emojisAnimals + emojisAnimals
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
