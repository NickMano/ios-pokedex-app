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
    @Published private(set) var isLoadingMore = false
    @Published private(set) var hasError = false
    
    // MARK: - Pagination properties
    private var currentOffset = 0
    private let pageSize = 100
    private var canLoadMore = true
    
    // MARK: - Private properties
    private let searchPokemonUseCase: SearchPokemonsUseCase
    
    // MARK: - Initializer
    init(searchPokemonUseCase: SearchPokemonsUseCase) {
        self.searchPokemonUseCase = searchPokemonUseCase
    }
    
    // MARK: - Public methods
    func onAppear() async {
        guard pokemons.isEmpty else { return }
        await loadPokemons()
    }
    
    func retryLoading() {
        Task {
            currentOffset = 0
            pokemons = []
            canLoadMore = true
            await loadPokemons()
        }
    }
    
    func loadMoreIfNeeded(currentPokemon pokemon: Pokemon) {
        guard let index = pokemons.firstIndex(where: { $0.identifier == pokemon.identifier }) else {
            return
        }
        
        let thresholdIndex = pokemons.count - 3
        
        guard index >= thresholdIndex else { return }
        
        Task {
            await loadMorePokemons()
        }
    }

    // MARK: - Private methods
    private func loadPokemons() async {
        guard !isLoading else { return }
        
        hasError = false
        isLoading = true
        defer { isLoading = false }
        
        do {
            let newPokemons = try await fetchPokemons(offset: currentOffset, limit: pageSize)
            pokemons = newPokemons
            currentOffset += pageSize
            canLoadMore = !newPokemons.isEmpty
        } catch {
            hasError = true
            canLoadMore = false
        }
    }
    
    private func loadMorePokemons() async {
        guard !isLoadingMore, !isLoading, canLoadMore else { return }
        
        isLoadingMore = true
        defer { isLoadingMore = false }
        
        do {
            let newPokemons = try await fetchPokemons(offset: currentOffset, limit: pageSize)
            
            let uniqueNewPokemons = newPokemons.filter { newPokemon in
                !pokemons.contains { $0.identifier == newPokemon.identifier }
            }
            
            pokemons.append(contentsOf: uniqueNewPokemons)
            currentOffset += pageSize
            
            canLoadMore = newPokemons.count == pageSize
        } catch {
            print("Error loading more pokemons: \(error)")
            canLoadMore = false
        }
    }
    
    private func fetchPokemons(offset: Int, limit: Int) async throws -> [Pokemon] {
        try await searchPokemonUseCase.execute(limit: limit, offset: offset)
    }
}
