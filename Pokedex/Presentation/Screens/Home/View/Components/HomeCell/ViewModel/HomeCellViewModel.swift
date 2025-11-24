//
//  HomeCellViewModel.swift
//  Pokedex
//
//  Migrated to MVVM pattern
//

import SwiftUI
import PokedexDomain

@MainActor
final class HomeCellViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published private(set) var isLoading = false
    @Published private(set) var hasError = false
    @Published private(set) var pokemonImage: Image?
    
    let pokemon: Pokemon
    
    // MARK: - Private Properties
    private let searchPokemonImageUseCase: SearchPokemonImageUseCase
    
    // MARK: - Computed Properties
    var backgroundColor: Color {
        pokemon.pokeTypes.first?.backgroundColor ?? .white
    }
    
    var pokemonInfo: PokemonInfo.StateViewModel {
        PokemonInfo.StateViewModel(
            number: pokemon.numberFormatted,
            name: pokemon.name,
            types: pokemon.pokeTypes,
            format: .home
        )
    }
    
    // MARK: - Initializer
    init(pokemon: Pokemon, searchPokemonImageUseCase: SearchPokemonImageUseCase) {
        self.pokemon = pokemon
        self.searchPokemonImageUseCase = searchPokemonImageUseCase
    }
    
    // MARK: - Public Methods
    func onAppear() async {
        await loadImage()
    }
    
    // MARK: - Private Methods
    private func loadImage() async {
        hasError = false
        isLoading = true
        defer { isLoading = false }
        
        do {
            let data = try await searchPokemonImageUseCase.execute(urlImage: pokemon.imageUrl)
            
            guard let uiImage = UIImage(data: data) else {
                hasError = true
                return
            }
            
            let image = Image(uiImage: uiImage)
            pokemonImage = image
        } catch {
            hasError = true
        }
    }
}
