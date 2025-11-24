//
//  HomeViewModel.swift
//  Pokedex
//
//  Migrated to MVVM pattern
//

import SwiftUI
import PokedexDomain

@MainActor
final class HomeViewModel: ObservableObject {
    // MARK: - Published Properties (Estado)
    @Published private(set) var pokemons: [Pokemon] = []
    @Published private(set) var isLoading = false
    @Published private(set) var hasError = false
    
    // MARK: - Private properties
    private let searchPokemonUseCase: SearchPokemonsUseCase
    
    // MARK: - Initializer
    init(searchPokemonUseCase: SearchPokemonsUseCase) {
        self.searchPokemonUseCase = searchPokemonUseCase
    }
    
    // MARK: - Public methods
    func onAppear() async {
        await loadPokemons()
    }
    
    func retryLoading() {
        Task {
            await loadPokemons()
        }
    }

    // MARK: - Private methods
    private func loadPokemons() async {
        hasError = false
        isLoading = true
        defer { isLoading = false }
        
        do {
            pokemons = try await searchPokemonUseCase.execute()
        } catch {
            hasError = true
        }
    }
}
