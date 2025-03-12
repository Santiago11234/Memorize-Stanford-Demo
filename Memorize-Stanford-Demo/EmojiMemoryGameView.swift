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
                .foregroundStyle(viewModel.color)
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





#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
