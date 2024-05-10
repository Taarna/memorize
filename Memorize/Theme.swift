//
//  Theme.swift
//  Memorize
//
//  Created by Ivana Rast on 10.05.2024..
//

import Foundation

protocol Theme {
    var name: String { get }
    var emojis: Array<String> { get }
    var numberOfPairs: Int { get }
    var color: String { get }
}

struct GameThemes {
    struct Animals: Theme {
        var name = "Animals"
        var emojis = ["🐶","🐱","🐭","🦊","🐸","🐤"]
        var numberOfPairs = 4
        var color = "green"
    }
    struct Vehicles: Theme {
        var name = "Vehicles"
        var emojis = ["🚗","🚙","🚎","🛺","🚢","✈️", "🏎️"]
        var numberOfPairs = 7
        var color = "red"
    }
    struct Food: Theme {
        var name = "Food"
        var emojis = ["🫐","🥨","🍔","🍖"]
        var numberOfPairs = 10
        var color = "blue"
    }
    
    func random() -> Theme {
        return [Animals(), Vehicles(), Food()].randomElement() as! Theme
    }
}
