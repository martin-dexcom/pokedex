//
//  CoreDataManager.swift
//  Pokedex
//
//  Created by Josué Arambula on 7/31/21.
//

import UIKit
import CoreData

protocol CoreDataCrudProtocol {
  func savePokemonInPokedex(pokemon: Pokemon)
}


final class CoreDataManager: CoreDataCrudProtocol {

  static let shared = CoreDataManager()

  func savePokemonInPokedex(pokemon: Pokemon) {

    // interact with Core Data along their classes
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

    //1
    let managedContext = appDelegate.persistentContainer.viewContext

    //2
    let entity = NSEntityDescription.entity(forEntityName: "PokemonCD", in: managedContext)!

    //3
    let pokemonObject = NSManagedObject(entity: entity, insertInto: managedContext)

    pokemonObject.setValue(pokemon.id, forKeyPath: "id")
    pokemonObject.setValue(pokemon.sprites?.frontDefault, forKey: "image")
    pokemonObject.setValue(pokemon.name, forKey: "name")
    pokemonObject.setValue(pokemon.stats?.first?.baseStat, forKey: "stat")
    pokemonObject.setValue(pokemon.types?.first?.type?.name, forKey: "type")

    //4
    do {
      // this line do the magic
      try managedContext.save()
    } catch let error as NSError {
      print("Could not save. \(error), \(error.userInfo)")
    }

  } // end func


}
