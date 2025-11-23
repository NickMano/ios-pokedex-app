//
//  ListPokemonsView.swift
//  Pokedex
//
//  Created by Manograsso, Nicolas on 23/11/2025.
//

import SwiftUI
import PokedexDomain

struct ListPokemonsView: View {
    let pokemons: [Pokemon]

    var body: some View {
        LazyVStack {
            ForEach(pokemons, id: \.identifier) {
                HomeCellView.build(data: $0)
            }
        }
    }
}
