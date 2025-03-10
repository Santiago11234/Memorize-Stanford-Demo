//
//  MemorizeGame.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/10/25.
//

// Arrays, Ints, Bools, etc
import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    func chooseCard(card: Card) {
        
    }
    
    struct Card {
        var content: CardContent
        var isFaceUp: Bool
        var isMatched: Bool
    }
}
