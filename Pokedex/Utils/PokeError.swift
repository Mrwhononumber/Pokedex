//
//  PokeError.swift
//  Pokedex
//
//  Created by Basem El kady on 12/26/21.
//

import Foundation

enum PokeError: String, Error {
    
    case invalidURL = " The URL you're using is invalid"
    case unableToComplete = "unable to complete your request, please check your internet connection"
    case invalidResponse = "Invalid response from the server, please try again"
    case invalidData = "the data received from the server is invalid, please try again"
}
