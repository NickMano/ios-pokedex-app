//
//  HomeCellModel.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 31/01/2023.
//

import SwiftUI
import PokedexDomain

final class HomeCellModel: ObservableObject, HomeCellModelStateProtocol {
    private var pokemon: Pokemon
    
    @Published var imageState: HomeCellTypes.Model.ImageState = .loading
    let routerSubject = HomeCellRouter.Subjects()
    
    var backgroundColor: Color {
        pokemon.pokeTypes.first?.backgroundColor ?? .white
    }
    
    var pokemonInfo: PokemonInfo.StateViewModel {
        PokemonInfo.StateViewModel(number: pokemon.numberFormatted,
                                   name: pokemon.name,
                                   types: pokemon.pokeTypes,
                                   format: .home)
    }
    
    init(pokemonInfo: Pokemon) {
        self.pokemon = pokemonInfo
    }
}

extension HomeCellModel: HomeCellModelActionsProtocol {
    func displayLoading() {
        imageState = .loading
    }
    
    func displayError() {
        imageState = .error
    }
    
    func update(_ image: Image) {
        imageState = .fetched(image)
    }
}

extension HomeCellModel: HomeCellModelRouterProtocol {
    func goToDetail(pokemon: Pokemon, image: Image?) {
        routerSubject.screen.send(.detail(pokemonData: pokemon, image: image))
    }
}

extension HomeCellTypes.Model {
    enum ImageState {
        case loading
        case fetched(Image)
        case error
    }
}
