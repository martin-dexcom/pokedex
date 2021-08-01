//
//  DetailViewModel.swift
//  Pokedex
//
//  Created by Martin García on 8/1/21.
//
import Foundation

protocol DetailViewModelProtocol {
    var name: String { get }
    var order: String { get }
    var type: String { get }
    var stats: [(name: String, power: String)] {
        get
    }
    var image: URL? { get }
}

struct DetailViewModel: DetailViewModelProtocol {
    let pokemon: Pokemon
    
    var name: String {
        pokemon.name?.uppercased() ?? ""
    }
    
    var order: String {
        guard let order = pokemon.order else {
            return ""
        }
        
        return "#\(order)"
    }
    
    var type: String {
        pokemon.types?.first?.type?.name ?? ""
    }
    
    var stats: [(name: String, power: String)] {
        guard let stats = pokemon.stats else {
            return []
        }
        
        let arrayStats: [(String, String)] = stats.compactMap { stat in
            guard let name = stat.stat?.name,
                  let power = stat.baseStat else {
                return nil
            }
            
            return (name.uppercased(), String(power))
        }
        
        return arrayStats
    }
    
    var image: URL? {
        guard let urlString = pokemon.sprites?.backDefault else {
            return nil
        }
        
        return URL(string: urlString)
    }
    
    
}
