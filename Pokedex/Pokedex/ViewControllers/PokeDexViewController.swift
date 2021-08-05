//
//  PokeDexViewController.swift
//  Pokedex
//
//  Created by Daniel Moreno on 7/19/21.
//

import Foundation
import UIKit

class PokedDexViewController: UIViewController {
    
    @IBOutlet weak var pokeSearchView: PokeSearchView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoView: InfoView!
    
    var pokemons: [PokemonCD] = []
    var filteredPokemons: [PokemonCD] = []
    var currentPokemon: Pokemon?
    
    override func viewDidLoad() {
        pokeSearchView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PokemonCell", bundle: .main), forCellReuseIdentifier: "PokemonCell")

        // TODO: Get pokemon count
        let title = pokemons.isEmpty
            ? "Go search some Pokemons!"
            : "You have \(pokemons.count) Pokemons!"
        pokeSearchView.title.text = title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        pokemons = CoreDataManager.shared.fetchPokemons() ?? []
        filteredPokemons = pokemons
        updateUI()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController,
              let detailVc = navController.topViewController as? DetailViewController else {
            return
        }
        detailVc.pokemon = currentPokemon
        detailVc.hideAddButton = true
    }
}

extension PokedDexViewController: PokeSearchDelegate {
    func searchedPokemon(pokemonName: String?) {
        searchPokemon(pokemonName: pokemonName)
    }
}

extension PokedDexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemonName = filteredPokemons[indexPath.row].name else {
            return
        }
        NetworkManager.shared.getPokemon(withName: pokemonName) { response in
            switch response {
            case .success(let pokemon):
                DispatchQueue.main.async {
                    self.currentPokemon = pokemon.first
                    self.performSegue(withIdentifier: "detailSegue", sender: self)
                }
                break
            case .failed:
                break
            }
        }
    }
}

extension PokedDexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let pokemonId = filteredPokemons[indexPath.row].id
        if editingStyle == .delete {
            filteredPokemons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataManager.shared.deletePokemonInPokedex(withId: Int(pokemonId))
        }
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
        return pokemonNameCell
    }
}
