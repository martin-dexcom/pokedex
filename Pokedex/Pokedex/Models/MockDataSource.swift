//
//  MockDataSource.swift
//  Pokedex
//
//  Created by Martin García on 7/24/21.
//

import Foundation

struct Pokemon {
    /// The name of the Pokemon
    let name: String
    /// The order of the Pokemon on the Pokedex App
    let order: Int
    let type: String
    let stats: [(name: String, power: Int)]
    let image: String
}
