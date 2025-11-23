//
//  HomeCellView.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 13/12/2022.
//

import SwiftUI
import PokedexDomain

struct HomeCellView: View {
    @StateObject var container: MVIContainer<HomeCellIntentProtocol, HomeCellModelStateProtocol>
    
    private var intent: HomeCellIntentProtocol { container.intent }
    private var state: HomeCellModelStateProtocol { container.model }
    
    var body: some View {
        ZStack {
            ZStack {
                state.backgroundColor
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
                    PokemonInfo(state: state.pokemonInfo)
                        .padding(.leading, 20)
                    
                    Spacer()
                }
            }
            .padding(.top, 25)
            
            HStack {
                Spacer()
                
                switch state.imageState {
                case .loading:
                    ProgressView()
                        .padding(.trailing, 42)
                        .padding(.top, 24)
                    
                case .fetched(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(.trailing, 20)
                    
                case .error:
                    EmptyView()
                }
            }
        }
        .frame(height: 140)
        .onAppear(perform: intent.viewOnAppear)
        .onTapGesture {
            intent.onTapCell()
        }
        .modifier(HomeCellRouter(subjects: state.routerSubject, intent: intent))
    }
}

struct HomeCellView_Previews: PreviewProvider {
    static let bulbasaur: Pokemon = Bundle.main.decode(file: "Bulbasaur", extesion: "json")
    
    static var previews: some View {
        VStack {
            HomeCellView.build(data: bulbasaur)
            HomeCellView.build(data: bulbasaur)
        }
        .padding()
    }
}
