//
//  DetailModule.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 01/02/2023.
//

import SwiftUI

enum DetailModule {
    static func build(data: DetailTypes.Intent.ExternalData) -> some View {
        let model = DetailModel()
        let intent = DetailIntent(model: model, externalData: data)
        let container = MVIContainer(intent: intent as DetailIntentProtocol,
                                     model: model as DetailModelStateProtocol,
                                     modelChangePublisher: model.objectWillChange)
        let view = DetailView(container: container)
        return view
    }
}
