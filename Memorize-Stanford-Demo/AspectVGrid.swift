//
//  aspectVGrid.swift
//  Memorize-Stanford-Demo
//
//  Created by Santiago Espinoza on 3/12/25.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    init (_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                aspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)

                }
            }
        }
        
    }
    
    private func gridItemWidthThatFits(count: Int, size: CGSize, aspectRatio: CGFloat) -> CGFloat {
        let count = CGFloat(count)
        var columnCount: CGFloat = 1
        
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
            
        } while columnCount < count
        
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
    

    
}
