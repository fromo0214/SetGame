//
//  AspectVGrid.swift
//  Set
//
//  Created by Fernando Romo on 3/29/25.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View{
    var items: [Item]
    var aspectRatio: CGFloat = 1
    @ViewBuilder var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader {geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                containerSize: geometry.size,
                atAspectRatio: aspectRatio)
            
            let columns = [GridItem(.adaptive(minimum: gridItemSize.width), spacing : 0)]
            //lazy vgrid uses less space
            LazyVGrid(columns: columns, spacing: 0){
                //id:  \.self
                ForEach(items){item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                        .frame(width: gridItemSize.width, height: gridItemSize.height)

                }
            }
        }
    }
    
    func gridItemWidthThatFits(
        count: Int,
        containerSize: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGSize{
        //        let count = CGFloat(count)
        //        var columnCount = 1.0
        //        repeat{
        //            let width = size.width / columnCount
        //            let height = width / aspectRatio
        //
        //            let rowCount = (count / columnCount).rounded(.up)
        //
        //            if rowCount * height < size.height {
        //                return (size.width / columnCount).rounded(.down)
        //            }
        //            columnCount += 1
        //        } while columnCount < count
        //        return min(size.width / count, size.height * aspectRatio).rounded(.down)
        guard count > 0 else { return CGSize(width: 120, height: 180) } // Default fallback size
        
        let maxColumns = min(CGFloat(count), floor(containerSize.width / 90)) // Max reasonable columns
        var columnCount = max(2, maxColumns) // At least 2 columns for reasonable layout
        
        repeat {
            let cardWidth = (containerSize.width - CGFloat(columnCount - 1) * 8) / CGFloat(columnCount)
            let cardHeight = cardWidth / aspectRatio
            let rowCount = ceil(CGFloat(count) / CGFloat(columnCount))
            
            if rowCount * (cardHeight + 8) <= containerSize.height {
                return CGSize(width: min(180, cardWidth), height: min(270, cardHeight)) // Set max limits
            }
            
            columnCount += 1
        } while columnCount < CGFloat(count)
        
        let finalWidth = (containerSize.width - CGFloat(columnCount - 1) * 8) / CGFloat(columnCount) * 1.1
        return CGSize(width: max(70, min(180, finalWidth)), height: max(100, min(270, finalWidth / aspectRatio)))
    }
}
