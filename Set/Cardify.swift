//
//  Cardify.swift
//  SetGame
//
//  Created by Fernando Romo on 3/4/25.
//

import SwiftUI

struct Cardify:ViewModifier{
    let borderColor: Color
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.fill(Color.white)
            base.strokeBorder(borderColor, lineWidth: Constants.lineWidth)
            content
            
        }
        .padding(5)
      }
        
    private struct Constants{
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 2
    }
}


extension View{
    func cardify(borderColor: Color) -> some View {
        return modifier(Cardify(borderColor: borderColor))
    }
}

