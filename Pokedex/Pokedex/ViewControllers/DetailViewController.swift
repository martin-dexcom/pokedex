//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Martin García on 7/18/21.
//

import UIKit
import SDWebImage
import Toaster

class DetailViewController: UIViewController {
    // MARK: - Properties
    var pokemon: Pokemon?
    var hideAddButton = false
    
    // MARK: - UI Elements
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSeries: UILabel!
    @IBOutlet weak var lblType: UILabel!
    
    @IBOutlet weak var vType: UIView!
    @IBOutlet weak var vStats: UIView!
    
    @IBOutlet weak var vsStats: UIStackView!
    
    @IBOutlet weak var imgSprite: UIImageView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
            super.viewDidLoad()
        setupUI()
        setupPokemonUI()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Remove the top bar
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    // MARK: - UI Setup
    
    /// Sets up some specific UI elements
    private func setupUI() {
        vType.withShadow()
        vType.round()
        vStats.round(radius: 30, corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        btnSave.isHidden = hideAddButton
    }
    
    /// Sets up the UI with Pokemon Data
    private func setupPokemonUI() {
        // Setup Labels
        guard let pokemon = self.pokemon else {
            return
        }
        lblName.text = pokemon.name?.capitalized
        lblSeries.text = "#\(pokemon.order ?? 0)"
        let pokemonType = pokemon.types?.first?.type?.name
        lblType.text = pokemonType?.capitalized
        
        // Setup Stats
        pokemon.stats?.forEach { stat in
            let statView = StatElement(name: stat.stat?.name ?? "", power: stat.baseStat ?? 0)
            statView.translatesAutoresizingMaskIntoConstraints = false
            vsStats.addArrangedSubview(statView)
        }
        
        // Setup images
        imgSprite.sd_setImage(with: URL(string: pokemon.sprites?.frontDefault ?? ""), completed: nil)
        
        // Setup colors
        let typeColor = UIColor.TypeColors.getColor(fromType: pokemonType ?? "")
        view.backgroundColor = typeColor
        vType.backgroundColor = typeColor
        btnSave.tintColor = typeColor
        
    }
    
    // MARK: - Actions
    @IBAction func actionButtonPressed(_ sender: Any) {
        guard let pokemon = self.pokemon else {
            return
        }
        CoreDataManager.shared.savePokemonInPokedex(pokemon: pokemon)
        let toast = Toast(text: "\(pokemon.name ?? "") was stored in the Pokedex", duration: Delay.short)
        toast.show()
    }
}
