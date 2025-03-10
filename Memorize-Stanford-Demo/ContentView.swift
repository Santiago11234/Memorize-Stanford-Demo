//
//  ContentView.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/10/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        
        Grid(horizontalSpacing: 2, verticalSpacing: 2) {
            CardView(emoji: "🤠", isFaceUp: true)
            CardView(emoji: "🤠", isFaceUp: false)
            CardView(emoji: "🤠", isFaceUp: true)
            CardView(emoji: "🤠", isFaceUp: false)
        }.padding()
    }


    private func card(emoji: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12).foregroundColor(.white)
            RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2).foregroundStyle(.orange)
            Text(emoji).font(.largeTitle).fontWeight(.bold)
        }
    }
}


struct CardView: View {
    var emoji: String
    var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2).foregroundStyle(.orange)
                Text(emoji).font(.largeTitle).fontWeight(.bold)
            } else {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.orange)
                RoundedRectangle(cornerRadius: 12).strokeBorder(lineWidth: 2).foregroundStyle(.orange)

            }
        }
    }
}









#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
