//
//  ErrorView.swift
//  Pokedex
//
//  Created by Manograsso, Nicolas on 23/11/2025.
//

import SwiftUI

struct ErrorView: View {
    let retryAction: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Error loading Pokémon")
                .font(.headline)
            
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}
