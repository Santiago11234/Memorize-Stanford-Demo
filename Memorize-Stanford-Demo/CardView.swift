//
//  CardView.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/12/25.
//

import SwiftUI

typealias Card = MemoryGame<String>.Card

struct CardView: View {
    let card: Card
    
    init(_ card: Card) {
        self.card = card
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 2
        static let inset: CGFloat = 5
        struct FontSize {
            static let largest: CGFloat = 200
            static let smallest: CGFloat = 10
            static let scaleFactor = smallest / largest
        }
        struct Pie {
            static let opacity: CGFloat = 0.5
            static let inset: CGFloat = 5
        }
    }
    
    var body: some View {
        Pie(endAngle: .degrees(240))
            .opacity(Constants.Pie.opacity)
            .overlay(
                Text(card.content)
                    .font(.system(size: Constants.FontSize.largest))
                    .minimumScaleFactor(0.01)
                    .multilineTextAlignment(.center)
                    .aspectRatio(1, contentMode: .fit)
                    .padding(Constants.Pie.inset)
            )
            .padding(Constants.inset)
            .cardify(isFaceUp: card.isFaceUp)
            .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


#Preview {
    HStack {
        CardView(Card(content: "X", isFaceUp: true, id: "test1"))
        CardView(Card(content: "X", id: "test1"))
        CardView(Card(content: "X", id: "test1"))
        CardView(Card(content: "X", id: "test1"))
    }.padding()
}
