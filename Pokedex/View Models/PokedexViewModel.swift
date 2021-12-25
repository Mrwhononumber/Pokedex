//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Basem El kady on 12/15/21.
//

import Foundation


class PokedexViewModelList {
    var pokedexViewModelArray: [PokedexViewModel]?
    var pokedexViewModelFilteredArray: [PokedexViewModel]?
    var firstEvolutionVM: PokedexViewModel?
    var seconedEvolutionVM: PokedexViewModel?
    
    // fetch evolution pokemons viewModels so it can get passed to the detail ViewController
    func getEvolutionPokemons (with selectedPoke: PokedexViewModel, completion: @escaping ()->())
    {
        
        if selectedPoke.evolutionIdArray!.count > 1 {
            firstEvolutionVM =  pokedexViewModelArray![(selectedPoke.evolutionIdArray?[0])!]
            seconedEvolutionVM = pokedexViewModelArray?[(selectedPoke.evolutionIdArray?[1])!]
            
            completion()
        }
        else if selectedPoke.evolutionIdArray!.count == 1 {
            firstEvolutionVM = pokedexViewModelArray?[(selectedPoke.evolutionIdArray?[0])!]
            seconedEvolutionVM = nil
            completion()
        }
        
    }
    
    // search the collectionView using the searchBar input
    func searchPokemons(with searchTerm:String, completion: @escaping ()->()) {
        pokedexViewModelFilteredArray = []
        if searchTerm == "" {
            pokedexViewModelFilteredArray = pokedexViewModelArray
            completion()
            
        }
        guard pokedexViewModelArray != nil else {return}
        for viewModel in pokedexViewModelArray! {
            if
                viewModel.name!.lowercased().contains(searchTerm.lowercased()) {
                pokedexViewModelFilteredArray?.append(viewModel)
                completion()
            }
        }
    }
    
    
    // reset the collectionView to it's default state when "cancel" or "X" (inside search bar) button get tapped
    func resetSearchToDefault(completion: @escaping ()->()){
        pokedexViewModelFilteredArray = pokedexViewModelArray
        completion()
    }


}


struct PokedexViewModel {
    
    let name: String?
    let imageUrl: String?
    let description: String?
    let height: Int?
    let weight: Int?
    let attack: Int?
    let defense: Int?
    let type: String?
    let id: Int?
    var evolutionChain: [EvolutionChain]?
    var evolutionIdArray: [Int]? {
        var array = [Int]()
        if evolutionChain != nil {
            for evolution in evolutionChain! {
                if Int (evolution.id!)! < 153 {
                    array.append(Int(evolution.id!)! - 1 )
                }
                
            }
        }
        
        return array
    }
    var evolutionLabel: String?
    
    init(pokemon: Pokemon) {
        self.name = pokemon.name
        self.imageUrl = pokemon.imageUrl
        self.description = pokemon.description
        self.height = pokemon.height
        self.weight = pokemon.weight
        self.attack = pokemon.attack
        self.defense = pokemon.defense
        self.type = pokemon.type
        self.id = pokemon.id
        self.evolutionChain = pokemon.evolutionChain
        if evolutionChain != nil {
            evolutionLabel = "Possible Evolutions"
        } else {
            evolutionLabel = " No Evolutions Available!"
        }
        
    }
}
    










