//
//  HomeCellProtocol.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 31/01/2023.
//

import SwiftUI
import PokedexDomain

// MARK: - View State
protocol HomeCellModelStateProtocol {
    var backgroundColor: Color { get }
    var pokemonInfo: PokemonInfo.StateViewModel { get }
    
    var imageState: HomeCellTypes.Model.ImageState { get }
    
    var routerSubject: HomeCellRouter.Subjects { get }
}

// MARK: - Intent Actions
protocol HomeCellModelActionsProtocol: AnyObject {
    func displayLoading()
    func displayError()
    func update(_ image: Image)
}

// MARK: - Route
protocol HomeCellModelRouterProtocol: AnyObject {
    func goToDetail(pokemon: Pokemon, image: Image?)
}
