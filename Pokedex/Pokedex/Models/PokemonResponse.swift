//
//  PokemonResponse.swift
//  Pokedex
//
//  Created by Josué Arambula on 7/31/21.
//

import Foundation

struct PokemonResponse: Decodable {

  let count: Int?
  let next: String?
  let results: [Results]

}

struct Results: Decodable {
  let name: String?
  let url: String?
}

// in case parse an emtpy model,

extension PokemonResponse {

  init() {
    self.count = 0
    self.next = ""
    self.results = []
  }
}
