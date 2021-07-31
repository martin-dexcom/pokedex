//
//  SearchViewDelegate.swift
//  Pokedex
//
//  Created by Martin García on 7/31/21.
//

import Foundation

protocol SearchViewDelegate {
    // Hey this method is only called if there's a value to be returned
    func searchedText(textSearched: String)
}
