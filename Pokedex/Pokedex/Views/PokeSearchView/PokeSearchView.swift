//
//  PokeSearchView.swift
//  Pokedex
//
//  Created by Daniel Moreno on 7/18/21.
//

import Foundation
import UIKit

class PokeSearchView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: PokeSearchDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    
    private func initView() {
        Bundle.main.loadNibNamed("PokeSearchView", owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        searchBar.searchTextField.delegate = self
    }
}

extension PokeSearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let name = textField.text {
            delegate?.searchedPokemon(pokemonName: name)
        }
        return true
    }
}


