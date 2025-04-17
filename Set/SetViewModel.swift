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
    @Published private(set) var dealtCards: [SetGameModel<Symbol>.Card] = []
    
    private var fullDeck: [SetGameModel<Symbol>.Card] = []
    
    init() {
        fullDeck = SetViewModel.generateFullDeck()
        self.model = SetGameModel(cards: fullDeck)
        dealInitialCards()
    }
    
    private func dealInitialCards(){
        dealMoreCards(count: 12)
    }
    
    func dealMoreCards(count: Int = 3) {
        let undealtCards = fullDeck.filter{card in
            !dealtCards.contains(where: { $0.id == card.id})
        }
        
        let newCards = undealtCards.prefix(count)
        dealtCards.append(contentsOf: newCards)
    }
    
    var cards: [Card] {
        return model.cards
    }
    
    func choose(_ card: Card) {
        model.choose(card)
        
        for index in dealtCards.indices{
            if let updated = model.cards.first(where: { $0.id == dealtCards[index].id}){
                dealtCards[index] = updated
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation {
                    self.removeMatchedCards()
                }
            }
    }
    
    func deal3Cards() {
        dealMoreCards()
    }
    
    static func generateFullDeck() -> [Card]{
        var id = 0
        var deck: [Card] = []
        
        for shape in Symbol.Shape.allCases{
            for color in Symbol.Color.allCases{
                for shading in Symbol.Shading.allCases{
                    for number in 1...3{
                        let symbol = Symbol(shape: shape, color: color, number: number, shading: shading)
                        deck.append(SetGameModel<Symbol>.Card(id: "\(id)", content: symbol))
                        id += 1
                    }
                }
            }
        }
        
       return deck.shuffled()
    }
    
    func removeMatchedCards(){
        dealtCards.removeAll(){ $0.isMatched }
    }
}
