//
//  EmojiMemoryGame.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/10/25.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["✌","😂","😝","😁","😱","👉","🙌","🍻","🔥","☀","🎈","🌹","💄","🎀","⚽","🎾","🏁","🤠", "😈", "💩", "👻"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        return MemoryGame(numberOfPairsOfCards: 7) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
        
    @Published private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
}
