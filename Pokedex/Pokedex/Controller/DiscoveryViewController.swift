//
//  DiscoveryViewController.swift
//  Pokedex
//
//  Created by Martin García on 7/25/21.
//

import UIKit

class DiscoveryViewController: UIViewController {
    
    var pokemons: [Pokemon] = []
    
    var selectedPokemon: Pokemon?
    
    var filteredPokemons: [Pokemon] = []
    
    @IBOutlet weak var pokemonTableView: UITableView!
    @IBOutlet weak var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonTableView.dataSource = self
        pokemonTableView.delegate = self
        searchView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? PokemonDetailViewController {
            detailVC.pokemon = selectedPokemon
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO updateUI()
        NetworkManager.shared.getPokemons{ response in
            switch response {
            case .success(let pokemons):
                self.pokemons = pokemons
                self.filteredPokemons = pokemons
                self.updateUI()
                break
            case .failed:
                break
            }
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async {
            self.pokemonTableView.reloadData()
        }
    }
    
    func filterPokemons(pokemonName: String) {
        if pokemonName.isEmpty {
            filteredPokemons = pokemons
        } else {
            filteredPokemons = pokemons.filter({ pokemon in
                return pokemon.name?.lowercased().contains(pokemonName.lowercased()) ?? false
            })
        }
        updateUI()
    }
}

extension DiscoveryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO change for the Pokemon model
        selectedPokemon = filteredPokemons[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
}

extension DiscoveryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Reuse cell and cast it as PokemonCell
        let pokemonCell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonCell
        // Get the Pokemon for this indexPatch
        let pokemon = filteredPokemons[indexPath.row]
        // Get url for pokeimage
        let imageUrl = URL(string: pokemon.sprites?.frontDefault ?? "")
        
        // Setting our Cell
        pokemonCell?.nameLabel.text = pokemon.name
        pokemonCell?.pokemonImage?.sd_setImage(with: imageUrl, completed: nil)
        pokemonCell?.typeLabel.text = pokemon.types?.first?.type?.name
        pokemonCell?.numberLabel.text = "#\(pokemon.order ?? 0)"
        
        return pokemonCell!
    }
}

extension DiscoveryViewController: SearchViewDelegate {
    func searchedText(textSearched: String) {
        filterPokemons(pokemonName: textSearched)
    }
}
