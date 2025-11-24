//
//  AboutView.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 15/12/2022.
//

import SwiftUI
import PokedexDomain

struct AboutView: View {
    @StateObject var container: MVIContainer<AboutIntentProtocol, AboutModelStateProtocol>
    
    private var intent: AboutIntentProtocol { container.intent }
    private var state: AboutModelStateProtocol { container.model }
    
    var body: some View {
        VStack(alignment: .leading) {
            switch state.speciesState {
            case.fetched:
                Text(state.description)
                    .font(.description)
                    .foregroundColor(.textNumber)
                    .padding(.top, 40)
                    .padding(.bottom, 32)

            case .loading:
                descriptionSkeleton()

            case .error:
                EmptyView()
            }
            
            pokedexDataView(state.pokedexData)
            trainingView(state.trainingData)
            breedingView(state.breedingData)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 40)
        .onAppear(perform: intent.viewOnAppear)
    }
}

// MARK: - Views
private extension AboutView {
    func descriptionSkeleton() -> some View {
        VStack(alignment: .leading) {
            Capsule()
                .frame(height: 8)
                .foregroundColor(.textGrey)
            
            Capsule()
                .frame(height: 8)
                .foregroundColor(.textGrey)
            
            Capsule()
                .frame(width: 100, height: 8)
                .foregroundColor(.textGrey)
        }
        .padding(.top, 40)
        .padding(.bottom, 32)
    }
    
    func pokedexDataView(_ data: PokedexDataModel) -> some View {
        VStack(alignment: .leading) {
            Text("Pokedex Data")
                .sectionTitle(color: state.sectionColor)
            
            switch state.speciesState {
            case .fetched:
                DataStackView(title: "Species", value: data.species)
                
            default:
                EmptyView()
            }
            
            DataStackView(title: "Height", value: data.height)
            DataStackView(title: "Weight", value: data.weight)
            AbilityStackView(abilities: data.abilities)
            WeakStackView(value: data.weaknesses)
        }
    }
    
    func trainingView(_ data: TrainingModel) -> some View {
        VStack(alignment: .leading) {
            Text("Training")
                .sectionTitle(color: state.sectionColor)
            
            DataStackView(title: "EV Yield", values: data.evYield)
            DataStackView(title: "Catch Rate", value: data.catchRate)
            DataStackView(title: "Base Friendship", value: data.baseFriendship)
            DataStackView(title: "Base Exp", value: data.baseExp)
            DataStackView(title: "Growth Rate", value: data.growthRate)
        }
    }
    
    func breedingView(_ data: BreedingModel) -> some View {
        VStack(alignment: .leading) {
            Text("Breeding")
                .sectionTitle(color: state.sectionColor)
            
            switch state.speciesState {
            case .fetched:
                GenderStackView(chanceToFemaleInEighths: data.gender)
                
            default:
                EmptyView()
            }
            
            switch state.eggGroupsState {
            case .fetched:
                DataStackView(title: "Egg Gropus", value: data.eggGroups)
                
            default:
                EmptyView()
            }
            
            switch state.speciesState {
            case .fetched:
                DataStackView(title: "Egg Cycles", value: data.eggCycles)
                
            default:
                EmptyView()
            }
        }
    }
}

struct PokemonAboutView_Previews: PreviewProvider {
    static let bulbasaur: Pokemon = Bundle.main.decode(file: "Bulbasaur", extesion: "json")
    
    static var previews: some View {
        AboutView.build(data: bulbasaur)
    }
}
