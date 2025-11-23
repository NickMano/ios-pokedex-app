//
//  HomeModule.swift
//  Pokedex
//
//  Factory for MVVM pattern
//

import SwiftUI
import PokedexDomain
import PokedexData

enum HomeModule {
    @MainActor static func build() -> some View {
        // Dependencies
        let repository = DefaultPokemonRepository()
        let useCase = DefaultSearchPokemonsUseCase(pokemonRepository: repository)
        
        // ViewModel
        let viewModel = HomeViewModel(searchPokemonUseCase: useCase)
        
        // View
        return HomeView(viewModel: viewModel)
    }
}
