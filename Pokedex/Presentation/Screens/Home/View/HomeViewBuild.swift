//
//  HomeViewBuild.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 31/01/2023.
//

import SwiftUI
import PokedexDomain
import PokedexData

extension HomeView {
    static func build() -> some View {
        let model = HomeModel()
        let repository = DefaultPokemonRepository()
        let useCase = DefaultSearchPokemonsUseCase(pokemonRepository: repository)
        let intent = HomeIntent(model: model, searchPokemonUseCase: useCase)
        let container = MVIContainer(intent: intent as HomeIntentProtocol,
                                     model: model as HomeModelStateProtocol,
                                     modelChangePublisher: model.objectWillChange)
        let view = HomeView(container: container)
        return view
    }
}
