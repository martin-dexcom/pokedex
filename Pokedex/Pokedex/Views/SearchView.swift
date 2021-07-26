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
    }
    
}
