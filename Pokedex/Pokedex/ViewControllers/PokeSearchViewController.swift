//
//  PokeSearchViewController.swift
//  Pokedex
//
//  Created by Daniel Moreno on 7/18/21.
//

import Foundation
import UIKit
import Toaster

class PokeSearchViewController: UIViewController {
    
    @IBOutlet weak var pokeSearchView: PokeSearchView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoView: InfoView!
    
    var pokemonNames: [String] = []
    var currentPokemon: Pokemon?
    
    override func viewDidLoad() {
        pokeSearchView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navController = segue.destination as? UINavigationController,
              let detailVc = navController.topViewController as? DetailViewController else {
            return
        }
        detailVc.pokemon = currentPokemon
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
        self.infoView.isHidden = !self.pokemonNames.isEmpty
        self.tableView.reloadData()
    }
    
    private func handleNewPokemon(pokemon: Pokemon?) {
        currentPokemon = pokemon
        if currentPokemon != nil {
            addPokemonToHistory()
            updateUI()
            showDetailView()
        }
    }
    
    private func addPokemonToHistory() {
        let pokeName = currentPokemon?.name?.capitalized ?? ""
        let pokeOrder = currentPokemon?.order ?? 0
        let pokemonNameAndId = "\(pokeName) #\(pokeOrder)"
        pokemonNames.append(pokemonNameAndId)
        updateUI()
    }
    
    private func showDetailView() {
        self.performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    private func searchPokemon(pokemonName: String?) {
        guard let pokemonName = pokemonName?.lowercased() else {
            return
        }
        NetworkManager.shared.getPokemon(withName: pokemonName) { response in
            switch response {
            case .success(let pokemons):
                DispatchQueue.main.async {
                    self.handleNewPokemon(pokemon: pokemons.first)
                }
                break
            case .failed:
                DispatchQueue.main.async {
                    let toast = Toast(text: "Pokemon not found", duration: Delay.short)
                    toast.show()
                }
                break
            }
        }
    }
}

extension PokeSearchViewController: PokeSearchDelegate {
    func searchedPokemon(pokemonName: String?) {
        searchPokemon(pokemonName: pokemonName)
    }
}

extension PokeSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "History"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonNameCell = tableView.dequeueReusableCell(withIdentifier: "PokemonNameCell") as? PokemonNameCell else {
            return UITableViewCell()
        }
        pokemonNameCell.pokemonName.text = pokemonNames[indexPath.row]
        return pokemonNameCell
    }
}
