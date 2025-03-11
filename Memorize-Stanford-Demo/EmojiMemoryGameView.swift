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
    
    @State var cardCount: Int = 5
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Button("Shuffle") {
                viewModel.shuffle();
                print("shuffling", viewModel.cards[0])
            }
//            Spacer()
//            cardCountAdjusters
        }.padding()

    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)]) {
            ForEach(viewModel.cards.indices, id: \.self) { index in
                CardView(viewModel.cards[index])
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
            }
        }
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardCountAdjusterButton(by: -1, symbol: "minus")
            Spacer()
            cardCountAdjusterButton(by: 1, symbol: "plus")
        }.font(.largeTitle)
    }
    
    func cardCountAdjusterButton(by offset: Int, symbol: String) -> some View {
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
        }.onTapGesture {
//            viewModel.choose(card)
        }
    }
}


#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
