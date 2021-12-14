//
//  Pokemon.swift
//  Pokedex
//
//  Created by Basem El kady on 12/11/21.
//

import Foundation
import UIKit

struct Pokemon: Decodable {
    
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
    lazy var image = UIImage()
    
    
    
    
}
//    var defense: Int?



struct EvolutionChain: Decodable {
    let id: String?
    let name: String?
}



