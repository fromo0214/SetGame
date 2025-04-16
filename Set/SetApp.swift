//
//  SetApp.swift
//  Set
//
//  Created by Fernando Romo on 3/18/25.
//

import SwiftUI

@main
struct SetApp: App {
    @StateObject var game = SetViewModel()
    
    var body: some Scene {
        WindowGroup {
            SetView(viewModel: game)
        }
    }
}
