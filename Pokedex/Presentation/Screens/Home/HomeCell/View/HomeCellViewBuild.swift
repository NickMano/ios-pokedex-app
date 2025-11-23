//
//  HomeCellViewBuild.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 31/01/2023.
//

import SwiftUI
import PokedexDomain
import PokedexData

extension HomeCellView {
    static func build(data: Pokemon) -> some View {
        let model = HomeCellModel(pokemonInfo: data)
        let repository = DefaultPokemonRepository()
        let useCase = DefaultSearchPokemonImageUseCase(pokemonRepository: repository)
        let intent = HomeCellIntent(model: model, pokemon: data, searchPokemonImageUseCase: useCase)
        let container = MVIContainer(intent: intent as HomeCellIntentProtocol,
                                     model: model as HomeCellModelStateProtocol,
                                     modelChangePublisher: model.objectWillChange)
        let view = HomeCellView(container: container)
        return view
    }
}
