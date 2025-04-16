//
//  Cardify.swift
//  SetGame
//
//  Created by Fernando Romo on 3/4/25.
//

import SwiftUI

struct Cardify:ViewModifier{
    
    func body(content: Content) -> some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.fill(Color.white)
            base.strokeBorder(.black, lineWidth: Constants.lineWidth)
            content
            
        }
        .padding(5)
      }
        
    private struct Constants{
        static let cornerRadius: CGFloat = 12
        static let lineWidth: CGFloat = 5
    }
}


extension View{
    func cardify(cardColor: Color) -> some View {
        return modifier(Cardify())
    }
}

