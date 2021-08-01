//
//  PokeDexViewController.swift
//  Pokedex
//
//  Created by Martin García on 7/31/21.
//

import UIKit

class PokeDexViewController: UIViewController {
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var pokemonsTableView: UITableView!
    
    var pokemons: [PokemonCD] = []
    
    var selectedPokemon: Pokemon?
    
    var filteredPokemons: [PokemonCD] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.delegate = self
        pokemonsTableView.dataSource = self
        pokemonsTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pokemons = CoreDataManager.shared.fetchPokemons() ?? []
        filteredPokemons = pokemons
        updateUI()
    }
    
    func updateUI() {
        pokemonsTableView.reloadData()
    }
    
    func transtionToDetail()  {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "detailSegue", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? PokemonDetailViewController {
            detailVC.pokemon = selectedPokemon
            detailVC.hideAddButton = true
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


extension PokeDexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemonName = self.filteredPokemons[indexPath.row].name ?? ""
        NetworkManager.shared.getPokemon(withName: pokemonName) { response in
            switch response {
            case .success(let pokemons):
                self.selectedPokemon = pokemons.first
                self.transtionToDetail()
                break
            case .failed:
                break
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pokemonId = filteredPokemons[indexPath.row].id
        if editingStyle == .delete {
            filteredPokemons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataManager.shared.deletePokemonInPokedex(withId: Int(pokemonId))
        }
    }
}

extension PokeDexViewController: UITableViewDataSource {
    
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
        pokemonCell?.setupWithPokemon(pokemon: pokemon)
        
        return pokemonCell!
    }
}

extension PokeDexViewController: SearchViewDelegate {
    func searchedText(textSearched: String) {
        filterPokemons(pokemonName: textSearched)
    }
}
