//
//  AboutIntent.swift
//  Pokedex
//
//  Created by nicolas.e.manograsso on 02/02/2023.
//

import PokedexDomain

final class AboutIntent {
    // MARK: - Model
    private weak var model: AboutModelActionsProtocol?
    
    // MARK: - UseCases
    private let weaknessesUseCase: GetWeaknessesUseCase
    
    // MARK: - Repository
    private let repository: PokemonRepository
    
    // MARK: - Business Data
    private let pokemon: Pokemon
    
    init(model: AboutModelActionsProtocol,
         externalData: Pokemon,
         weaknessesUseCase: GetWeaknessesUseCase,
         repository: PokemonRepository) {
        self.model = model
        pokemon = externalData
        self.weaknessesUseCase = weaknessesUseCase
        self.repository = repository
    }
}

extension AboutIntent: AboutIntentProtocol {
    func viewOnAppear() {
        model?.setupScreen(pokemon)
        
        fetchSpecies()
        fetchWeaknesses()
    }
}

private extension AboutIntent {
    func fetchSpecies() {
        model?.displaySpeciesLoading()
        
        Task {
            do {
                let pokemonId = pokemon.id
                let species = try await repository.fetchSpecies(pokemonId)
                fetchEggGroups(from: species)
                
                model?.update(species)
            } catch {
                print("Caca")
            }
        }
    }
    
    func fetchWeaknesses() {
        let typeNames = pokemon.types.map { $0.type.name }
        
        Task {
            do {
                let weaknesses = try await weaknessesUseCase.execute(typeNames: typeNames)
                model?.update(weaknesses)
            } catch {
                print("Caca")
            }
        }
    }
    
    func fetchEggGroups(from species: PokemonSpecies) {
        model?.displayEggGroupsLoading()
        
        Task {
            do {
                let groupNames = species.eggGroups.map { $0.name }
                
                if groupNames.count == 1, let eggGroupName = groupNames.first {
                    let eggGroup = try await self.repository.fetchEggGroup(eggGroupName)
                    model?.update([eggGroup])
                } else {
                    try await withThrowingTaskGroup(of: EggGroup.self) { group in
                        for groupName in groupNames {
                            group.addTask {
                                let response = try await self.repository.fetchEggGroup(groupName)
                                return response
                            }
                        }
                        
                        var eggGroups: [EggGroup] = []
                        
                        for try await eggGroup in group {
                            eggGroups.append(eggGroup)
                        }
                        
                        model?.update(eggGroups)
                    }
                }
            } catch {
            }
        }
    }
}
