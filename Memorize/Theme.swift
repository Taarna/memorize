//
//  Theme.swift
//  Memorize
//
//  Created by Ivana Rast on 10.05.2024..
//

import Foundation

struct Theme {
    var name: String
    var emojis: Array<String>
    var numberOfPairs: Int
    var color: String
}

struct Themes {
    private static let Animals = Theme(name: "Animals", emojis: ["🐶","🐱","🐭","🦊","🐸","🐤"], numberOfPairs: 4, color:"green")
    private static let Vehicles = Theme(name: "Vehicles", emojis: ["🚗","🚙","🚎","🛺","🚢","✈️", "🏎️"], numberOfPairs: 7, color: "red")
    private static let Food = Theme(name: "Food", emojis: ["🫐","🥨","🍔","🍖", "🍕", "🍤", "🍰", "🍡", "🌮"], numberOfPairs: 8, color: "blue")
    
    private static var allThemes: Array<Theme> {
        [Animals, Vehicles, Food]
    }
    
    static func randomTheme() -> Theme {
        let randomIndex = Int.random(in: allThemes.indices)
        return allThemes[randomIndex]
    }
}
