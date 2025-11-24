//
//  HomeCellModule.swift
//  Pokedex
//
//  Migrated to MVVM pattern
//

import SwiftUI
import PokedexDomain
import PokedexData

@MainActor
enum HomeCellModule {
    static func build(data: Pokemon) -> some View {
        // Dependencies
        let repository = DefaultPokemonRepository()
        let useCase = DefaultSearchPokemonImageUseCase(pokemonRepository: repository)
        
        // ViewModel
        let viewModel = HomeCellViewModel(pokemon: data, searchPokemonImageUseCase: useCase)
        
        // View
        return HomeCellView(viewModel: viewModel)
    }
}
