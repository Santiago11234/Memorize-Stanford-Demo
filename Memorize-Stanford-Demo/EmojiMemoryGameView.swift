//
//  EmojiMemoryGameView.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/10/25.
//

import SwiftUI
import SwiftData

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    @State var cardCount: Int = 5
    
    
    var body: some View {
        VStack {
                cards
                .animation(.default, value: viewModel.cards)
            Button("Shuffle") {
                viewModel.shuffle();
            }
//            Spacer()
//            cardCountAdjusters
        }.padding()

    }
    
    
    private var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            CardView(card)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }
    }
    
    private var cardCountAdjusters: some View {
        HStack {
            cardCountAdjusterButton(by: -1, symbol: "minus")
            Spacer()
            cardCountAdjusterButton(by: 1, symbol: "plus")
        }.font(.largeTitle)
    }
    
    private func cardCountAdjusterButton(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
            print("cardCount changed", cardCount)
        }, label: {
            Image(systemName: "rectangle.stack.badge.\(symbol).fill")
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > viewModel.cards.count)
    }
    
}


struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2).foregroundStyle(.orange)
                Text(card.content).font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill(.orange).opacity(card.isFaceUp ? 0 : 1)
        }.opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
