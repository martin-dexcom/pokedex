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

enum PokeApiResponse {
    case success(pokemon: [Pokemon])
    case failed
}

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
    var nextPokemonsUrl: URL?
    
    /// Only gets 6 pokemons at a time.
    func getPokemons(callback: @escaping (PokeApiResponse) -> Void) {
        var urlComponent = URLComponents(string: baseURL.absoluteString)
        urlComponent?.queryItems = [
            URLQueryItem(name: "limit", value: "6"),
        ]
        let nextUrl = nextPokemonsUrl != nil ? nextPokemonsUrl : urlComponent?.url
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
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(PokemonsResponse.self, from: data)
                if let nextPageUrl = response.next {
                    self.nextPokemonsUrl = URL(string: nextPageUrl)
                }
                let names = response.results.map { result in
                    result.name ?? ""
                }
                
                self.getPokemons(withNames: names) { response in
                    callback(response)
                }
            } catch {
                print("Error decoding Pokemon: \(error)")
                return
            }
        }.resume()
    }
    
    /// Get pokemons with the names  on the array
    func getPokemons(withNames names: [String], callback: @escaping (PokeApiResponse) -> Void) {
        let dispatchGroup = DispatchGroup()
        var pokemons: [Pokemon] = []

        names.forEach { name in
            dispatchGroup.enter()
            self.getPokemon(withName: name.lowercased() ) { response in
                switch response {
                case .success(let resPokemons):
                    if let pokemon = resPokemons.first {
                        pokemons.append(pokemon)
                    }
                    dispatchGroup.leave()
                    break
                case .failed:
                    dispatchGroup.leave()
                    break
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            callback(.success(pokemon: pokemons))
        }
    }
    
    func getPokemon(withName: String, callback: @escaping (PokeApiResponse) -> Void) {
        let requestURL = baseURL.appendingPathComponent(withName + "/")
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = HTTPMethod.get.rawValue
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching pokemon: \(error)")
                callback(.failed)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                callback(.success(pokemon: [pokemon]))
            } catch {
                print("Error decoding Pokemon: \(error)")
                callback(.failed)
                return
            }
        }.resume()
    }
}
