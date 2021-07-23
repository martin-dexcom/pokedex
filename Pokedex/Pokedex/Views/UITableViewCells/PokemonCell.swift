//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Daniel Moreno on 7/19/21.
//

import Foundation
import UIKit

class PokemonCell: UITableViewCell {
    @IBOutlet weak var pokemonView: UIView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNumberLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonTypeLabel: UILabel!
    
    
    override func layoutSubviews() {
        pokemonView.layer.cornerRadius = 5
        pokemonTypeLabel.layer.masksToBounds = true
        pokemonTypeLabel.layer.cornerRadius = 5
    }
    
    func setupWithPokemon(pokemon: Pokemon) {
        let pokemonType = pokemon.types?.first?.type?.name
        let pokemonOrder = "#\(pokemon.order ?? 0)"
        let pokemonName = pokemon.name?.capitalized
        let typeColor = UIColor.TypeColors.getColor(fromType: pokemonType ?? "")
        pokemonView.backgroundColor = typeColor
        pokemonTypeLabel.backgroundColor = typeColor
        pokemonImageView.sd_setImage(with: URL(string: pokemon.sprites?.frontDefault ?? ""), completed: nil)
        pokemonNumberLabel.text = pokemonOrder
        pokemonNameLabel.text = pokemonName
        pokemonTypeLabel.text = pokemonType?.capitalized
    }
    
    func setupWithPokemon(pokemon: PokemonCD) {
        let pokemonType = pokemon.type
        let pokemonOrder = "#\(pokemon.id)"
        let pokemonName = pokemon.name?.capitalized
        let typeColor = UIColor.TypeColors.getColor(fromType: pokemonType ?? "")
        pokemonView.backgroundColor = typeColor
        pokemonTypeLabel.backgroundColor = typeColor
        pokemonImageView.sd_setImage(with: URL(string: pokemon.image ?? ""), completed: nil)
        pokemonNumberLabel.text = pokemonOrder
        pokemonNameLabel.text = pokemonName
        pokemonTypeLabel.text = pokemonType?.capitalized
    }

    
}
