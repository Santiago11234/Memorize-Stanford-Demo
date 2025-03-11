//
//  MemorizeGame.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/10/25.
//

// Arrays, Ints, Bools, etc
import Foundation

struct MemoryGame<CardContent> {
    //only setting the card is private. Anyone can view it. Called "Access Control"
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    struct Card {
        let content: CardContent
        var isFaceUp: Bool = true
        var isMatched: Bool = false
    }
    

}
