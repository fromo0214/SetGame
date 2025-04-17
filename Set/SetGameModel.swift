//
//  SetGameModel.swift
//  Set
//
//  Created by Fernando Romo on 3/25/25.
// Model

import Foundation

struct SetGameModel<CardContent> where CardContent: Equatable {
    //private(set) - other code can access cards property
    private(set) var cards: [Card]
    
    init(cards: [Card]){
        self.cards = cards
    }
    
    mutating func choose(_ card: Card) {
        print("chose", card)
        //Find the index of the selected card
        guard let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
              !cards[chosenIndex].isMatched else { return }
        
        //Get current selections
        let selectedIndices = cards.indices.filter{ cards[$0].isSelected }
        
        if cards[chosenIndex].isSelected {
            if selectedIndices.count < 3{
                cards[chosenIndex].isSelected = false
            }
            return
        }
        
        //select the card
        cards[chosenIndex].isSelected = true
        
        let newSelectedIndices = cards.indices.filter { cards[$0].isSelected }
        
        if newSelectedIndices.count == 3{
            let selectedCards = newSelectedIndices.map { cards[$0] }
            if isValidSet(selectedCards){
                //Mark cards as matched
                print("Valid Set!")
                for index in newSelectedIndices {
                    cards[index].isMatched = true
                    cards[index].isSelected = false
                    cards[index].isMisMatched = false
                    print(cards[index].isMatched)
                }

            }else{
                print("Invalid Set!")
                for index in newSelectedIndices {
//                    cards[index].isSelected = false
                    cards[index].isMisMatched = true
                }
            }
        }else if newSelectedIndices.count > 3 {
            //Reset all other selections and select only the new one
            for index in cards.indices{
                cards[index].isSelected = false
                cards[index].isMisMatched = false
            }
            cards[chosenIndex].isSelected = true
        }
    }
    
    private func isValidSet(_ cards: [Card]) -> Bool {
        guard cards.count == 3 else { return false }

        // Downcast to Symbol type
        guard let symbol1 = cards[0].content as? Symbol,
              let symbol2 = cards[1].content as? Symbol,
              let symbol3 = cards[2].content as? Symbol else {
            return false
        }

        // Helper to check all same or all different
        func isValid<T: Equatable>(_ a: T, _ b: T, _ c: T) -> Bool {
            return (a == b && b == c) || (a != b && b != c && a != c)
        }

        return isValid(symbol1.shape, symbol2.shape, symbol3.shape)
            && isValid(symbol1.color, symbol2.color, symbol3.color)
            && isValid(symbol1.number, symbol2.number, symbol3.number)
            && isValid(symbol1.shading, symbol2.shading, symbol3.shading)
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    mutating func newGame(){
        shuffle()
    }
    
    
    //Card Model
    struct Card: Equatable, Identifiable{
        var id: String
        let content: CardContent
        var isSelected: Bool = false
        var isMatched: Bool = false
        var isMisMatched: Bool = false
        
    }
}

