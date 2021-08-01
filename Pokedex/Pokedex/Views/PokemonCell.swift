//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Martin García on 7/25/21.
//

import UIKit

class PokemonCell: UITableViewCell {
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backGroundView.layer.cornerRadius = 5
    }
    
    func setupWithPokemon(pokemon: Pokemon) {
        // Get url for pokeimage
        let imageUrl = URL(string: pokemon.sprites?.frontDefault ?? "")
        
        // Setting our Cell
        let type = pokemon.types?.first?.type?.name
        nameLabel.text = pokemon.name
        pokemonImage?.sd_setImage(with: imageUrl, completed: nil)
        typeLabel.text = type
        numberLabel.text = "#\(pokemon.order ?? 0)"
        backGroundView.backgroundColor = UIColor.TypeColors.getColor(fromType: type ?? "")
    }
    
    func setupWithPokemon(pokemon: PokemonCD) {
        // Get url for pokeimage
        let imageUrl = URL(string: pokemon.image ?? "")
        
        // Setting our Cell
        let type = pokemon.type ?? ""
        nameLabel.text = pokemon.name
        pokemonImage?.sd_setImage(with: imageUrl, completed: nil)
        typeLabel.text = type
        numberLabel.text = "#\(pokemon.id)"
        backGroundView.backgroundColor = UIColor.TypeColors.getColor(fromType: type)

    }
}
