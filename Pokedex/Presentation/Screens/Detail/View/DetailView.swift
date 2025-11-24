//
//  DetailView.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 14/12/2022.
//

import SwiftUI
import SwiftUtils
import PokedexDomain

struct DetailView: View {
    @StateObject var container: MVIContainer<DetailIntentProtocol, DetailModelStateProtocol>
    
    private var intent: DetailIntentProtocol { container.intent }
    private var state: DetailModelStateProtocol { container.model }
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundView()
                titleView()
                
                ScrollView {
                    headerView()
                    
                    switch state.contentState {
                    case .fetched:
                        AboutView.build(data: state.pokemon)
                            .background(.white)
                            .cornerRadius(24)

                    default:
                        EmptyView()
                    }
                }
            }
        }
        .onAppear(perform: intent.viewOnAppear)
    }
}

private extension DetailView {
    func backgroundView() -> some View {
        LinearGradient(
            gradient: Gradient(stops: [
                Gradient.Stop(color: state.backgroundColor ?? .normalType, location: 0.5),
                Gradient.Stop(color: .white, location: 0.5)
            ]),
            startPoint: .top,
            endPoint: .bottom)
        .ignoresSafeArea()
    }
    
    func titleView() -> some View {
        VStack {
            LinearGradient(gradient: .vectorGradient, startPoint: .top, endPoint: .bottom)
                .mask(
                    Text(state.name)
                        .font(.hugeTitle)
                        .lineLimit(1)
                        .frame(width: 2000)
                )
                .frame(height: 100)
            
            Spacer()
        }
    }
    
    func headerView() -> some View {
        HStack(alignment: .center) {
            state.image?
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 160, maxHeight: 160)
                .padding(.trailing, 24)
            
            switch state.contentState {
            case .fetched(let pokemonInfo):
                PokemonInfo(state: pokemonInfo)

            default:
                EmptyView()
            }
        }
        .padding()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let bulbasaur: Pokemon = Bundle.main.decode(file: "Bulbasaur", extesion: "json")
    
    static var previews: some View {
        DetailModule.build(data: DetailTypes.Intent.ExternalData(pokemon: bulbasaur, image: .bulbasaur))
    }
}
