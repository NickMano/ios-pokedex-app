//
//  HomeCellIntent.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 31/01/2023.
//

import SwiftUI
import PokedexDomain

final class HomeCellIntent {
    // MARK: Model
    private weak var model: HomeCellModelActionsProtocol?
    private weak var routeModel: HomeCellModelRouterProtocol?

    // MARK: UseCases
    private let searchPokemonImageUseCase: SearchPokemonImageUseCase

    // MARK: Business Data
    private var pokemon: Pokemon
    private var image = Image("")

    // MARK: Life cycle
    init(model: HomeCellModelActionsProtocol & HomeCellModelRouterProtocol,
         pokemon: Pokemon,
         searchPokemonImageUseCase: SearchPokemonImageUseCase) {
        self.model = model
        routeModel = model
        self.pokemon = pokemon
        self.searchPokemonImageUseCase = searchPokemonImageUseCase
    }
}

extension HomeCellIntent: HomeCellIntentProtocol {
    func viewOnAppear() {
        Task {
            model?.displayLoading()
            
            do {
                let data = try await searchPokemonImageUseCase.execute(urlImage: pokemon.imageUrl)
                
                guard let uiImage = UIImage(data: data) else {
                    throw NSError()
                }

                image = Image(uiImage: uiImage)
                
                model?.update(image)
            } catch {
                model?.displayError()
            }
        }
    }
    
    func onTapCell() {
        routeModel?.goToDetail(pokemon: pokemon, image: image)
    }
}
