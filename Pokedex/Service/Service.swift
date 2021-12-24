//
//  Service.swift
//  Pokedex
//
//  Created by Basem El kady on 12/11/21.
//

import Foundation
import UIKit

class Service {
    
    static let shared = Service()
    
    private let baseUrl = "https://pokedex-bb36f.firebaseio.com/pokemon.json"
    
    func fetchPokemon(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        
        guard let pokemonUrl = URL(string:baseUrl) else { return }
        
        let task = URLSession.shared.dataTask(with: pokemonUrl) { data, response, error in
            
            // Handle error
            if let error = error {
                print("Failed to fetch data with error", error.localizedDescription)
                completion(.failure(error))
                return
            }
            guard let data = data?.parseData(removeString: "null,") else {return}
            
            do {
                
                let resultArray = try JSONDecoder().decode([Pokemon].self, from: data)
                
                
                DispatchQueue.main.async {
                    completion(.success(resultArray))
                }
                
            } catch {
                
                print("Error happened while decoding the data", error)
            }
            
        }
        task.resume()
    }
    
    
    func fetchImage(url: String, completion: @escaping (Result<(UIImage), Error>) -> Void ){
        
        guard let ImageUrl = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: ImageUrl) { data, response, error in
            guard error == nil else {
                print ("Error happened while downloading the Image")
                completion(.failure(error!))
                return
            }
            guard let ImageData = data else { return }
            guard let pokemonImage = UIImage(data: ImageData) else { return }
            
            DispatchQueue.main.async {
                completion(.success(pokemonImage))
            }
            
        }
        
        task.resume()
    }
}


extension Data {
    func parseData(removeString string: String) -> Data? {
        let dataAsString = String(data: self, encoding: .utf8)
        let parsedDataString = dataAsString?.replacingOccurrences(of: string, with: "")
        guard let data = parsedDataString?.data(using: .utf8) else { return nil }
        return data
    }
}

