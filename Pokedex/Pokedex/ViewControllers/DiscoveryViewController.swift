//
//  DiscoveryViewController.swift
//  Pokedex
//
//  Created by Daniel Moreno on 7/19/21.
//

import Foundation
import UIKit

class DiscoveryViewController: UIViewController {
    
    @IBOutlet weak var pokeSearchView: PokeSearchView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoView: InfoView!
    
    var currentPokemon: Pokemon?
    var pokemons: [Pokemon] = []
    var filteredPokemons: [Pokemon] = []
    var firstLoad = true
    
    override func viewDidLoad() {
        pokeSearchView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "PokemonCell", bundle: nil), forCellReuseIdentifier: "PokemonCell")

        pokeSearchView.title.text = "Discover new Pokemons!"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
        NetworkManager.shared.getPokemons { response in
            switch response {
            case .success(let pokemons):
                self.pokemons.append(contentsOf: pokemons)
                if self.firstLoad {
                    self.filteredPokemons = self.pokemons
                }
                self.updateUI()
                break
            case .failed:
                break
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // TODO: Probably move this common code somewhere
        guard let pokeSearchView = self.pokeSearchView else {
            return
        }
        let left = NSLayoutConstraint(item: pokeSearchView, attribute: .leading, relatedBy: .equal, toItem: pokeSearchView.contentView, attribute: .leading, multiplier: 1, constant: 0)
        let right = NSLayoutConstraint(item: pokeSearchView, attribute: .trailing, relatedBy: .equal, toItem: pokeSearchView.contentView, attribute: .trailing, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: pokeSearchView, attribute: .bottom, relatedBy: .equal, toItem: pokeSearchView.contentView, attribute: .bottom, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: pokeSearchView, attribute: .top, relatedBy: .equal, toItem: pokeSearchView.contentView, attribute: .top, multiplier: 1, constant: 0)
        pokeSearchView.addConstraints([left, right, bottom, top])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController,
              let detailVc = navController.topViewController as? DetailViewController else {
            return
        }
        detailVc.pokemon = currentPokemon
    }

    private func updateUI() {
        infoView.isHidden = !pokemons.isEmpty
        tableView.reloadData()
    }
    
    private func searchPokemon(pokemonName: String?) {
        defer {
            updateUI()
        }
        guard let name = pokemonName,
              !name.isEmpty else {
            filteredPokemons = pokemons
            return
        }
        
        filteredPokemons = pokemons.filter({ pokemon in
            pokemon.name?.lowercased().contains(name.lowercased()) ?? false
        })
    }
}

extension DiscoveryViewController: PokeSearchDelegate {
    func searchedPokemon(pokemonName: String?) {
        searchPokemon(pokemonName: pokemonName)
    }
}

extension DiscoveryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentPokemon = filteredPokemons[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
}

extension DiscoveryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Pokemons"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonNameCell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonCell else {
            return UITableViewCell()
        }
        pokemonNameCell.setupWithPokemon(pokemon: filteredPokemons[indexPath.row])
        
        // TODO: Update cell with actual pokemon models

        return pokemonNameCell
    }
}

