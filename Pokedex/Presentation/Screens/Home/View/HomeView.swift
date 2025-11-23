//
//  HomeView.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 13/12/2022.
//

import SwiftUI
import PokedexDomain

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel
    
    var body: some View {
        NavigationView {
            content
        }
        .task { await viewModel.onAppear() }
        .preferredColorScheme(.light)
    }
}

// MARK: - Subviews
private extension HomeView {
    var content: some View {
        ScrollView {
            ZStack {
                GeometryReader { geo in
                    PokeballGradient()
                        .frame(width: geo.size.width, height: geo.size.width)
                        .padding(.top, -(geo.size.width / 2))
                        .ignoresSafeArea()
                }
                
                VStack(alignment: .leading) {
                    Text("Pokedex")
                        .font(.title.bold())
                        .padding(.bottom, 10)
                    
                    Text("Search for Pokémon by name or using the National Pokédex number")
                        .foregroundColor(.textGrey)
                    
                    switch viewModel.contentState {
                    case .loading:
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)

                    case .fetched(let pokemons):
                        ListPokemonsView(pokemons: pokemons)
                    
                    case .error:
                        ErrorView(retryAction: viewModel.retryLoading)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    HomeModule.build()
}
