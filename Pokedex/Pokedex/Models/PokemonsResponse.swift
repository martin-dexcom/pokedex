//
//  PokemonsResponse.swift
//  Pokedex
//
//  Created by Josué Arambula on 7/15/21.
//

import Foundation




// API reference
// http://pokeapi.co/api/v2/pokemon/
// here is the names and url for all of them

// MARK: - HTTPPokeapiCoAPIV2Pokemon Model

struct PokemonsResponse: Decodable {
    let count: Int?
    let next: String?
    let results: [Results]
}

// MARK: - Result

struct Results: Decodable {
    let name: String?
    let url: String?
}

// MARK: - Extensions

/// In case the parse returns an empty Model, then create an empty struct to avoid the error
extension PokemonsResponse {

    init() {
        self.count = 0
        self.next = ""
        self.results = []
    }
}



