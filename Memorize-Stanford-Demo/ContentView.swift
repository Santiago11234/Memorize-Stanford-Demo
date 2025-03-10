//
//  ContentView.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    let emojis: [String] = ["✌","😂","😝","😁","😱","👉","🙌","🍻","🔥","🌈","☀","🎈","🌹","💄","🎀","⚽","🎾","🏁","🤠", "😈", "💩", "👻"]
    @State var cardCount: Int = 4
    
    
    var body: some View {
        VStack {
            cards
            Spacer()
            cardCountAdjusters
        }.padding()

    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(emoji: emojis[index])
            }
        }.padding()
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardCountAdjuster(by: -1, symbol: "minus")
            Spacer()
            cardCountAdjuster(by: 1, symbol: "plus")
        }.font(.largeTitle)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
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
    ContentView()
}
