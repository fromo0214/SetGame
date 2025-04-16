//
//  SetViewModel.swift
//  Set
//
//  Created by Fernando Romo on 3/30/25.
//  ViewModel

import SwiftUI

class SetViewModel: ObservableObject {
    typealias Card = SetGameModel<Symbol>.Card
    
    @Published private var model: SetGameModel<Symbol>
    
    private var symbols: [Symbol]
 
    
    init() {
        let initialSymbols = SetViewModel.generateSymbols()
        self.symbols = initialSymbols
        self.model = SetGameModel(cardContentFactory: initialSymbols)
    }
    
    private static func createSetGame() -> SetGameModel<Symbol>{
        print("Creating set game!")
        
        let symbols: [Symbol] = generateSymbols()
        
        return SetGameModel(cardContentFactory: symbols)
            
    }
    
    var cards: [Card] {
        return model.cards
    }
    
    private static func generateSymbols() -> [Symbol]{
        var symbols: [Symbol] = []
        
        for shape in Symbol.Shape.allCases{
            for color in Symbol.Color.allCases{
                for shading in Symbol.Shading.allCases{
                    for number in 1...3{
                        symbols.append(Symbol(shape: shape, color: color, number: number, shading: shading))
                    }
                }
            }
        }
        
        return symbols
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    
    
}
