//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Basem El kady on 12/15/21.
//

import Foundation

class PokedexViewModel {
    
    let name: String?
    let imageUrl: String?
    let description: String?
    let height: Int?
    let weight: Int?
    let attack: Int?
    let defense: Int?
    let type: String?
    let id: Int?
    let evolutionChain: [EvolutionChain]?
    var evolutionArray: [Int]?
    //    let image: UIImage?
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
        if let  evolutionChain = evolutionChain {
            for evolution in pokemon.evolutionChain! {

                self.evolutionArray?.append(Int(evolution.id!)!)
            }
            
        }
    }



}

//        func getEvo () ->[Pokemon]? {
//
//            var pokemonsArray:[Pokemon]
//            var evoArray:[Pokemon]
//            Service.shared.fetchPokemon { result in
//                switch result{
//
//                case .success(let pokemons):
//                    pokemonsArray = pokemons
//                case .failure(let error):
//                    print("error in the viewModel", error)
//                }
//            }
//            guard evolutionChain != nil else {return nil}
//            var idArray:[String] = []
//            for evolution in evolutionChain ?? [] {
//                idArray.append(evolution.id!)
//
//            }
//            //             Map the arrray to integers
//            let intArray: [Int]? = idArray.map({ item in
//                Int(item)!
//            })
//            if let intArray = intArray {
//
//                intArray.forEach { id in
//                    if id != nil, id < 153 {
//                        evoArray.append(pokemonsArray[id-1])
//
//                    } else {
//                        return
//                    }
//
//
//                }
//            }
//            return evoArray
//
//        }
//
//    }
//
//}







