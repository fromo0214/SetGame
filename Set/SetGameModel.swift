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
    
    init(cardContentFactory: [CardContent]){
        cards = []
        
        // Shuffles cards and picks 12 random cards
        let initialContents = cardContentFactory.shuffled().prefix(20)
        
        
        //UUID ensures each card has a unique id 
        for (_, content) in initialContents.enumerated(){
            cards.append(Card(id: UUID().uuidString, content: content))
        }   
    }
    
    mutating func choose(_ card: Card) {
        print("chose", card)
        
        var selectedCards: [Card] = []
        
        
        
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    mutating func newGame(){
        shuffle()
    }
    
    mutating func deal3Cards(){
        
    }
    
    
    //Card Model
    struct Card: Equatable, Identifiable{
        var id: String
        let content: CardContent
        
        
    }
}

