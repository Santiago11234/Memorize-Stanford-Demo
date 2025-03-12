//
//  MemorizeGame.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/10/25.
//

// Arrays, Ints, Bools, etc
import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    var indexOfTheOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter { index in cards[index].isFaceUp}.only
        }
        set {
            return cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex)A"))
            cards.append(Card(content: content, id: "\(pairIndex)B"))
        }
    }
    
    
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
            }
            
        } else {
            print("Index not found")
        }
    }
    
    
    private func index(of card: Card) -> Int? {
        for index in cards.indices {
            if(cards[index] == card) {
                return index
            }
        }
        return nil
    }
    
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
             "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "")"
        }
         
        let content: CardContent
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        
        var id: String
    }

}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
