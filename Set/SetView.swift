//
//  ContentView.swift
//  Set
//
//  Created by Fernando Romo on 3/18/25.
//  View

import SwiftUI

struct SetView: View {
    @ObservedObject var viewModel: SetViewModel
    
    typealias Card = SetGameModel<Symbol>.Card
    private let aspectRatio: CGFloat = 3/5
    private let spacing: CGFloat = 3
    var body: some View {//
        VStack{
            Text("Set").font(.largeTitle)
            ScrollViewReader { proxy in
                cards
            }
            Button("Draw 3 more cards"){
                viewModel.deal3Cards()
            }.font(Font.system(size: 30))
        }.padding(spacing)
    }
    
    private var cards: some View{
        withAnimation{
            AspectVGrid(viewModel.dealtCards, aspectRatio: aspectRatio){ card in
                return CardView(card)
                    .padding(spacing)
                    .onTapGesture {
                        withAnimation{
                            viewModel.choose(card)
                        }
                    }
            }.padding(.horizontal)
        }
    }
    
}

struct EmojiMemoryView_Previews: PreviewProvider {
    static var previews: some View{
        SetView(viewModel: SetViewModel())
    }
}


