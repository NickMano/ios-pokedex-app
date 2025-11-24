//
//  HomeCellView.swift
//  Pokedex
//
//  Created by Manograsso, Nicolas on 24/11/2025.
//

import SwiftUI
import PokedexDomain

struct HomeCellView: View {
    @StateObject var viewModel: HomeCellViewModel
    
    var body: some View {
        NavigationLink(value: PokemonDetailNavigationData(pokemon: viewModel.pokemon, image: viewModel.pokemonImage)) {
            cellContent
        }
        .buttonStyle(PlainButtonStyle())
        .task { await viewModel.onAppear() }
    }
    
    private var cellContent: some View {
        ZStack {
            backgroundLayer
            pokemonImageLayer
        }
        .frame(height: 140)
    }
    
    private var backgroundLayer: some View {
        ZStack {
            viewModel.backgroundColor
                .cornerRadius(10)
            
            LinearGradient(gradient: .vectorGradient, startPoint: .top, endPoint: .bottom)
                .mask(Image.dotsMedium
                    .resizable()
                    .scaledToFit()
                )
                .padding(.top, 8)
                .padding(.bottom, 78)
                .padding(.trailing)
            
            HStack {
                Spacer()
                
                LinearGradient(gradient: .vectorGradient, startPoint: .top, endPoint: .bottom)
                    .mask(Image.pokeball
                        .resizable()
                        .scaledToFit()
                    )
                    .frame(width: 140, height: 140)
                    .padding(.vertical, -16)
                    .padding(.trailing, -16)
            }
            
            HStack {
                PokemonInfo(state: viewModel.pokemonInfo)
                    .padding(.leading, 20)
                
                Spacer()
            }
        }
        .padding(.top, 25)
    }
    
    private var pokemonImageLayer: some View {
        HStack {
            Spacer()
            
            if viewModel.isLoading {
                ProgressView()
                    .padding(.trailing, 42)
                    .padding(.top, 24)
            } else if viewModel.hasError {
                EmptyView()
            } else if let image = viewModel.pokemonImage {
                image
                    .resizable()
                    .scaledToFit()
                    .padding(.trailing, 20)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let bulbasaur: Pokemon = Bundle.main.decode(file: "Bulbasaur", extesion: "json")
    
    NavigationStack {
        VStack {
            HomeCellModule.build(data: bulbasaur)
            HomeCellModule.build(data: bulbasaur)
        }
        .padding()
    }
}
