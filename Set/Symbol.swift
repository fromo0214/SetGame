//
//  Symbol.swift
//  Set
//
//  Created by Fernando Romo on 3/29/25.
//

import Foundation

struct Symbol: Equatable{
    enum Shape: String, CaseIterable {
        case diamond
        case rectangle
        case oval
    }
    
    enum Color: String, CaseIterable {
        case red
        case green
        case purple
    }
    
    enum Shading: String, CaseIterable {
        case solid, striped, open
    }
    
    var shape: Shape
    var color: Color
    var number: Int
    var shading: Shading
}
