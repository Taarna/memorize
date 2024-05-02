//
//  ContentView.swift
//  Memorize
//
//  Created by Ivana Rast on 29.04.2024..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView(isFaceUp: false)
            CardView(isFaceUp: false)
            CardView(isFaceUp: false)
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    @State var isFaceUp = false
    
    var body: some View {
        let baseCard = RoundedRectangle(cornerRadius: 12)
        ZStack {
            if isFaceUp {
                baseCard.fill(.white)
                baseCard.strokeBorder(lineWidth: 2)
                Text("☺️").font(.largeTitle)
            } else {
                baseCard.fill()
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ContentView()
}
