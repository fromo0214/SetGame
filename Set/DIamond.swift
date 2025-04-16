//
//  Diamond.swift
//  Set
//
//  Created by Fernando Romo on 3/25/25.
//

import SwiftUI
import CoreGraphics

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
               
               let top = CGPoint(x: rect.midX, y: rect.minY)
               let right = CGPoint(x: rect.maxX, y: rect.midY)
               let bottom = CGPoint(x: rect.midX, y: rect.maxY)
               let left = CGPoint(x: rect.minX, y: rect.midY)
               
               path.move(to: top)
               path.addLine(to: right)
               path.addLine(to: bottom)
               path.addLine(to: left)
               path.addLine(to: top)
               
               return path
    }
    
   
}

