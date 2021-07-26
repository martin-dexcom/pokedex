//
//  DiscoveryViewController.swift
//  Pokedex
//
//  Created by Martin García on 7/25/21.
//

import UIKit

class DiscoveryViewController: UIViewController {
    
    let pokemons = MockDataSource.pokemons
    var selectedPokemon: Pokemon?
    
    @IBOutlet weak var pokemonTableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? PokemonDetailViewController {
            detailVC.pokemon = selectedPokemon
        }
    }
    
}

extension DiscoveryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPokemon = pokemons[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
}

extension DiscoveryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse cell and cast it as PokemonCell
        let pokemonCell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonCell
        // Get the Pokemon for this indexPatch
        let pokemon = pokemons[indexPath.row]
        // Get url for pokeimage
        let imageUrl = URL(string: pokemon.image)
        
        // Setting our Cell
        pokemonCell?.nameLabel.text = pokemon.name
        pokemonCell?.pokemonImage?.sd_setImage(with: imageUrl, completed: nil)
        pokemonCell?.typeLabel.text = pokemon.type
        pokemonCell?.numberLabel.text = "#\(pokemon.order)"
        
        return pokemonCell!
    }
    
    
}
