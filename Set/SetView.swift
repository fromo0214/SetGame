//
//  ContentView.swift
//  Set
//
//  Created by Fernando Romo on 3/18/25.
//View

import SwiftUI

struct SetView: View {
    @ObservedObject var viewModel: SetViewModel
    
    typealias Card = SetGameModel<Symbol>.Card
    private let aspectRatio: CGFloat = 2/3
    private let spacing: CGFloat = 3
    var body: some View {
        
        ScrollView {
            cards
        }
        .padding(spacing)
    }
    
    private var cards: some View{
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio){ card in
            return CardView(card)
                .padding(spacing)
                .onTapGesture {
                    viewModel.choose(card)
                }
        }.padding(.horizontal)
    }
    
}

struct EmojiMemoryView_Previews: PreviewProvider {
    static var previews: some View{
        SetView(viewModel: SetViewModel())
    }
}


