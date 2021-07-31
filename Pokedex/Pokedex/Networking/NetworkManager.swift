//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Josué Arambula on 7/31/21.
//

import Foundation


enum HTTPMethod: String {
  case get = "GET"
  case put = "PUT"
  case post = "POST"
  case delete = "DELETE"
}

enum PokeApiResponse {
  case success(pokemon: [Pokemon])
  case failed
}


final class NetworkManager {

  static let shared = NetworkManager()

  let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
  // https://pokeapi.co/api/v2/pokemon/gloom
  var nextPokemonsURL: URL?


  func getPokemons(callback: @escaping (PokeApiResponse) -> Void) {

    var urlComponent = URLComponents(string: baseURL.absoluteString)
    urlComponent?.queryItems = [
      URLQueryItem(name: "limit", value: "6")
    ]

    let nextUrl = nextPokemonsURL != nil ? nextPokemonsURL : urlComponent?.url

    guard let url = nextUrl else {
      callback(.failed)
      return
    }

    var request = URLRequest(url: url)
    request.httpMethod = HTTPMethod.get.rawValue

    URLSession.shared.dataTask(with: request) { (data, _, error) in

      if let error = error {
        print("Error fetching pokemon: \(error)")
        return
      }

      guard let data = data else {
        print("No data")
        return
      }

      do {
        // parse the data from the server to our models

        let response = try JSONDecoder().decode(PokemonResponse.self, from: data)
        // testing
        print(response)
        // to get the url of the next page
        if let nextPageUrl = response.next {
          self.nextPokemonsURL = URL(string: nextPageUrl)
        }

        // filter, map, flatmap, etc
        let names = response.results.map { result in
          result.name ?? ""
        }
        // testing
        print(names)
        self.getPokemons(withNames: names) { response in
          callback(response)
        }

      } catch {
        print("Error decoding Pokemons: \(error)")
        return
      }

    }.resume()

  }

  func getPokemons(withNames names: [String], callback: @escaping (PokeApiResponse) -> Void ) {

    // 1 DispatchGroup
    let dispatchGroup = DispatchGroup()
    var pokemons: [Pokemon] = []

    names.forEach { name in

      // 2 when start
      dispatchGroup.enter()
      self.getPokemon(withName: name.lowercased()) { response in

        switch response {

          case .success(let resultPokemons) :
            if let pokemon = resultPokemons.first {
              pokemons.append(pokemon)
            }
            // 3 leave the dispatch
            dispatchGroup.leave()
            break
        case .failed:
          dispatchGroup.leave()
          break
        }
      }
    }// for each finish

    // 4 notify the task has complete
    dispatchGroup.notify(queue: .main) {
      callback(.success(pokemon: pokemons))
    }

  }// end getPokemons


  // to retreive only 1 pokemon by name
  func getPokemon(withName: String, callback: @escaping (PokeApiResponse) -> Void) {

    let requestURL = baseURL.appendingPathComponent(withName + "/")
    var request = URLRequest(url: requestURL)
    request.httpMethod = HTTPMethod.get.rawValue

    URLSession.shared.dataTask(with: request) { (data, _, error) in
      if let error = error {
        print("Error fetching pokemon: \(error)")
        return
      }
      guard let data = data else {
        print("No data")
        return
      }
      do{
        let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
        callback(.success(pokemon: [pokemon]))

      } catch {
        print("Error decoding Pokemons: \(error)")
        return
      }
    }.resume()
  }// func end


}
