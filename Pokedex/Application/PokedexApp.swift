//
//  PokedexApp.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 12/09/2022.
//

import SwiftUI

@main
struct PokedexApp: App {
    var body: some Scene {
        WindowGroup {
            HomeModule.build()
        }
    }
}
