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
    
}
