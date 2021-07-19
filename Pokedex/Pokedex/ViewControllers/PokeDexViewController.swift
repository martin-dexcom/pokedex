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
    
    var pokemonNames: [String] = []
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        pokeSearchView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        // TODO: Get pokemon count
        let title = pokemonNames.isEmpty
            ? "Go search some Pokemons!"
            : "You have \(pokemonNames.count) Pokemons!"
        pokeSearchView.title.text = title
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
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
        infoView.isHidden = !pokemonNames.isEmpty
        tableView.reloadData()
    }
    
    private func searchPokemon(pokemonName: String?) {
        // TODO: Filter Pokemons (No appending should be done here)
        if let name = pokemonName {
            pokemonNames.append(name)
            updateUI()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // TODO: Get ViewController and send pokemon data
    }
}

extension PokedDexViewController: PokeSearchDelegate {
    func searchedPokemon(pokemonName: String?) {
        searchPokemon(pokemonName: pokemonName)
    }
}

extension PokedDexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: SEND POKEMON TO DETAIL on prepare for segue
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
}

extension PokedDexViewController: UITableViewDataSource {
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
        return pokemonNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonNameCell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell") as? PokemonCell else {
            return UITableViewCell()
        }
        
        
        // TODO: Update cell with actual pokemon models

        return pokemonNameCell
    }
}
