//
//  EmojiMemoryGameView.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/10/25.
//

import SwiftUI
import SwiftData

struct EmojiMemoryGameView: View {
    let emojis: [String] = ["✌","😂","😝","😁","😱","👉","🙌","🍻","🔥","🌈","☀","🎈","🌹","💄","🎀","⚽","🎾","🏁","🤠", "😈", "💩", "👻"]
    @State var cardCount: Int = 18
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
//            Spacer()
//            cardCountAdjusters
        }.padding()

    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(emoji: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }.padding()
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
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
}


struct CardView: View {
    var emoji: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack(alignment: .center) {
            
            let base: RoundedRectangle = RoundedRectangle(cornerRadius: 12)

            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2).foregroundStyle(.orange)
                Text(emoji).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill(.orange).opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }.padding(5)
    }
}


#Preview {
    EmojiMemoryGameView()
}
