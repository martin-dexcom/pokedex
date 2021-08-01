//
//  SearchView.swift
//  Pokedex
//
//  Created by Martin García on 7/25/21.
//

import UIKit

class SearchView: UIView {
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initViews()
    }
    
    private func initViews() {
        Bundle.main.loadNibNamed("SearchView", owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        searchBar.searchTextField.delegate = self
    }
    
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text {
            delegate?.searchedText(textSearched: text)
        }
        return true
    }
}
