//
//  PokemonNameCell.swift
//  Pokedex
//
//  Created by Daniel Moreno on 7/18/21.
//

import Foundation
import UIKit

class PokemonNameCell: UITableViewCell {
    @IBOutlet weak var pokemonName: UILabel!
    @IBOutlet weak var pokemonNameView: UIView!
    
    override func layoutSubviews() {
        pokemonNameView.layer.cornerRadius = 5
    }
}
