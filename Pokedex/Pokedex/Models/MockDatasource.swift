//
//  MockDatasource.swift
//  Pokedex
//
//  Created by Martin García on 7/18/21.
//

import Foundation

struct MockDataSource {
    static let pikachu = Pokemon(abilities: [],
                                 baseExperience: 0,
                                 forms: [],
                                 gameIndices: [],
                                 height: 4,
                                 heldItems: [],
                                 id: 25,
                                 isDefault: true,
                                 locationAreaEncounters: "https://pokeapi.co/api/v2/pokemon/25/encounters",
                                 moves: [],
                                 name: "Pikachu",
                                 order: 35,
                                 pastTypes: [],
                                 species: Species(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon-species/25/"),
                                 sprites: Sprites(backDefault: "",
                                                  backFemale: "",
                                                  backShiny: "",
                                                  backShinyFemale: "",
                                                  frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
                                                  frontFemale: "",
                                                  frontShiny: "",
                                                  frontShinyFemale: "",
                                                  other: nil,
                                                  versions: nil,
                                                  animated: nil),
                                 stats: [
                                    Stat(baseStat: 35, effort: 0, stat: Species(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")),
                                    Stat(baseStat: 55, effort: 0, stat: Species(name: "attack", url: "https://pokeapi.co/api/v2/stat/2/")),
                                    Stat(baseStat: 50, effort: 0, stat: Species(name: "defense", url: "https://pokeapi.co/api/v2/stat/3/")),
                                 ],
                                 types: [TypeElement(slot: 1, type: Species(name: "electric", url: "https://pokeapi.co/api/v2/type/13/"))],
                                 weight: 60)
}
