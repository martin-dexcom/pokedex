//
//  ViewController.swift
//  Pokedex
//
//  Created by Martin García on 7/12/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.


      let network = NetworkManager()
      network.getAllPokemons()

      // test
      network.getPokemon(withName: "bulbasaur")

    }
}

