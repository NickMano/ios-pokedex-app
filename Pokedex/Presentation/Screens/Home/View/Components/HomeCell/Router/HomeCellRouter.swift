//
//  HomeCellRouter.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 01/02/2023.
//

import SwiftUI
import PokedexDomain

struct HomeCellRouter: RouterProtocol {
    typealias RouterScreenType = ScreenType
    typealias RouterAlertType = AlertScreen

    let subjects: Subjects
    let intent: HomeCellIntentProtocol
}

// MARK: - Navigation Screens

extension HomeCellRouter {
    enum ScreenType: RouterScreenProtocol {
        case detail(pokemonData: Pokemon, image: Image?)

        var routeType: RouterScreenPresentationType {
            switch self {
            case .detail:
                return .navigationLink
            }
        }
    }

    @ViewBuilder
    func makeScreen(type: RouterScreenType) -> some View {
        switch type {
        case let .detail(pokemonData, image):
            DetailView.build(data: DetailTypes.Intent.ExternalData(pokemon: pokemonData, image: image))
        }
    }

    func onDismiss(screenType: RouterScreenType) {}
}

// MARK: - Alerts
extension HomeCellRouter {
    enum AlertScreen: RouterAlertScreenProtocol {}

    func makeAlert(type: RouterAlertType) -> Alert {
        Alert(title: Text(""))
    }
}
