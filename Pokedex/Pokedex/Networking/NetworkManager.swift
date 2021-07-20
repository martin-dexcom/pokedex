//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Josué Arambula on 7/15/21.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case delete = "DELETE"
}


class NetworkManager {
    static let shared = NetworkManager()

    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var pokedexModel: Pokedex?
    var pokemonModel: Pokemon?


  func getAllPokemons(completion: @escaping  ([Pokedex]) -> Void) {
    let requestURL = baseURL

    var request = URLRequest(url: requestURL)
    request.httpMethod = HTTPMethod.get.rawValue

    URLSession.shared.dataTask(with: request) { (data, _, error) in
        if let error = error {
            print("Error fetching pokemon: \(error)")
            return
        }

        guard let data = data else { return }

        do {
            let pokemon = try JSONDecoder().decode(Pokedex.self, from: data)
            self.pokedexModel = pokemon
            // Return the result with the completion handler.
            DispatchQueue.main.async {
              completion([pokemon])
            }
          print(self.pokedexModel?.results ?? "no results")
        } catch {
            print("Error decoding Pokemon: \(error)")
            return
        }
    }.resume()
  }


  func getPokemon(withName: String, completion: @escaping  ([Pokemon]) -> Void) {
      let requestURL = baseURL.appendingPathComponent(withName + "/")

      var request = URLRequest(url: requestURL)
      request.httpMethod = HTTPMethod.get.rawValue

      URLSession.shared.dataTask(with: request) { (data, _, error) in
          if let error = error {
              print("Error fetching pokemon: \(error)")
              return
          }

          guard let data = data else { return }

          do {
              let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
              self.pokemonModel = pokemon
              // Return the result with the completion handler.
              DispatchQueue.main.async {
                  completion([pokemon])
              }
          } catch {
              print("Error decoding Pokemon: \(error)")
              return
          }
      }.resume()
    }


  func getPokemon(byId: Int, completion: @escaping  ([Pokemon]) -> Void) {
    let requestURL = baseURL.appendingPathComponent("\(byId)" + "/")

    var request = URLRequest(url: requestURL)
    request.httpMethod = HTTPMethod.get.rawValue

    URLSession.shared.dataTask(with: request) { (data, _, error) in
        if let error = error {
            print("Error fetching pokemon: \(error)")
            return
        }

        guard let data = data else { return }

        do {
            let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
            self.pokemonModel = pokemon
            // Return the result with the completion handler.
            DispatchQueue.main.async {
                 completion([pokemon])
             }
        } catch {
            print("Error decoding Pokemon: \(error)")
            return
        }
    }.resume()
  }


}
