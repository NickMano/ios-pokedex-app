//
//  PokemonDetailNavigationData.swift
//  Pokedex
//
//  Navigation data for Pokemon detail screen
//

import SwiftUI
import PokedexDomain

struct PokemonDetailNavigationData: Hashable {
    let pokemon: Pokemon
    let image: Image?
    
    // Hashable conformance
    static func == (lhs: PokemonDetailNavigationData, rhs: PokemonDetailNavigationData) -> Bool {
        lhs.pokemon.id == rhs.pokemon.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(pokemon.id)
    }
}
