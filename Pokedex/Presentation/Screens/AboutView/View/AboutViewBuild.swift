//
//  AboutViewBuild.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 02/02/2023.
//

import SwiftUI
import PokedexDomain
import PokedexData

extension AboutView {
    static func build(data: Pokemon) -> some View {
        let model = AboutModel()
        let pokemonRepository = DefaultPokemonRepository()
        let typeRepository = DefaultTypeRepository()
        let weaknessesUseCase = DefaultGetWeaknessesUseCase(typeRepository: typeRepository)
        let intent = AboutIntent(
            model: model,
            externalData: data,
            weaknessesUseCase: weaknessesUseCase,
            repository: pokemonRepository
        )
        let container = MVIContainer(intent: intent as AboutIntentProtocol,
                                     model: model as AboutModelStateProtocol,
                                     modelChangePublisher: model.objectWillChange)
        let view = AboutView(container: container)
        return view
    }
}
