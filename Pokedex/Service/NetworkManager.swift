//
//  Service.swift
//  Pokedex
//
//  Created by Basem El kady on 12/11/21.
//

import Foundation
import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    
    func fetchPokemon(completion: @escaping (Result<[Pokemon], PokeError>) -> Void) {
        
        guard let pokemonUrl = URL(string:Constants.pokemonServer.pokemonURL) else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))

            }
            return }
        
        let task = URLSession.shared.dataTask(with: pokemonUrl) { data, response, error in
            
            if error != nil {
            
                DispatchQueue.main.async {
                    completion(.failure(.unableToComplete))

                }
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidResponse))
                }
                return
            }
            
            guard let data = data?.parseData(removeString: "null,") else {return}
            
            do {
                
                let resultArray = try JSONDecoder().decode([Pokemon].self, from: data)
                
                
                DispatchQueue.main.async {
                    completion(.success(resultArray))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
            }
            
        }
        task.resume()
    }
    
    
    
    func fetchImage(url: String, completion: @escaping (Result<(UIImage), PokeError>) -> Void ){
        
        guard let ImageUrl = URL(string: url) else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            
            return }
        let task = URLSession.shared.dataTask(with: ImageUrl) { data, response, error in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.unableToComplete))
                }
               
                return
            }
            guard let ImageData = data else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
                
                return }
            guard let pokemonImage = UIImage(data: ImageData) else {
                DispatchQueue.main.async {
                    completion(.failure(.invalidData))
                }
               
                return }
            
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

