//
//  MockDataSource.swift
//  Pokedex
//
//  Created by Martin García on 7/24/21.
//

import Foundation

struct MockDataSource {
    static let pokemon = Pokemon(name: "Bulbasaur",
                          order: 35,
                          type: "grass",
                          stats: [
                            ("HP", 55),
                            ("Attack", 35),
                            ("Defense", 99)
                          ],
                          image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    static let pokemon2 = Pokemon(name: "Pikachu",
                          order: 1,
                          type: "electric",
                          stats: [
                            ("HP", 55),
                            ("Attack", 35),
                            ("Defense", 99)
                          ],
                          image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")

    static let pokemons = [pokemon, pokemon2]

}





struct Pokemon {
    /// The name of the Pokemon
    let name: String
    /// The order of the Pokemon on the Pokedex App
    let order: Int
    let type: String
    let stats: [(name: String, power: Int)]
    let image: String
}
