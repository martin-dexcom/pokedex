//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Martin García on 7/24/21.
//

import UIKit
import SDWebImage
// MARK: - Pokemon Controller
class PokemonDetailViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrder: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var imgPokemon: UIImageView!
    
    @IBOutlet weak var vStats: UIView!
    
    
    
    let pokemon = Pokemon(name: "Bulbasaur",
                          order: 35,
                          type: "grass",
                          stats: [
                            ("HP", 55),
                            ("Attack", 35),
                            ("Defense", 99)
                          ],
                          image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        // Setting up our labels
        lblName.text = pokemon.name.uppercased()
        lblOrder.text = "#\(pokemon.order)"
        lblType.text = pokemon.type.lowercased()
        
        // Setting up our image
        let url = URL(string: pokemon.image)
        
        if let unwrappedURL = url {
            imgPokemon.sd_setImage(with: unwrappedURL, completed: nil)
        }
        
        // Add a corner radius
        vStats.roundCorners(withRadius: 30)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
