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
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                        Spacer()
                    } else if viewModel.hasError {
                        ErrorView(retryAction: viewModel.retryLoading)
                    } else {
                        listPokemonsView
                    }
                }
            }
            .padding()
        }
    }
    
    var listPokemonsView: some View {
        LazyVStack {
            ForEach(viewModel.pokemons, id: \.identifier) { pokemon in
                HomeCellView.build(data: pokemon)
                    .onAppear {
                        viewModel.loadMoreIfNeeded(currentPokemon: pokemon)
                    }
            }
            
            if viewModel.isLoadingMore {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeModule.build()
}
