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
    @Published var contentState: ContentState = .loading
    
    // MARK: - Private properties
    private let searchPokemonUseCase: SearchPokemonsUseCase
    private var pokemons: [Pokemon] = []
    
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
        contentState = .loading
        
        do {
            pokemons = try await searchPokemonUseCase.execute()
            contentState = .fetched(pokemons)
        } catch {
            contentState = .error
        }
    }
}

// MARK: - Content State
extension HomeViewModel {
    enum ContentState {
        case loading
        case fetched([Pokemon])
        case error
    }
}
