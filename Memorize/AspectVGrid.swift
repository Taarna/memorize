//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Ivana Rast on 24.05.2024..
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    let aspectRatio: CGFloat
    var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = 80.0
//            gridItemWidthThatFits(
//                count: items.count,
//                size: geometry.size,
//                atAspectRatio: aspectRatio
//            )
            LazyVGrid(
                columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)],
                spacing: 0
            ) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
        }
    }
    
    func gridItemWidthThatFits(
        count: Int,
        size: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let count = CGFloat(count)
        var columnCount = 1.0
        
        repeat {
            let width = size.width / columnCount
            let height = width / aspectRatio
            
            let rowCount = (count / columnCount).rounded(.up)
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        
        print(min(size.width / count, size.height * aspectRatio).rounded(.down))
        
        return min(size.width / count, size.height * aspectRatio).rounded(.down)
    }
}
