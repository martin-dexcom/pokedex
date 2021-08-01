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
  func deletePokemonInPokedex(withId id: Int)
  func fetchPokemons() -> [PokemonCD]?
  func countPokemons() -> Int
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


  func fetchPokemons() -> [PokemonCD]? {

    // data for the TableView
    var items: [PokemonCD]?

    // as we know the container is setup in the AppDelegate, so we need to refer that container
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }

    // we need to create a context from its container
    let managedContext = appDelegate.persistentContainer.viewContext

    // fetch the data from core data to display in the TableView
    do {
      // this line does the magic
      items = try managedContext.fetch(PokemonCD.fetchRequest())
      if let items = items, !items.isEmpty {
        // testing
        print(" bring data from Core Data")
        return items
      } else {
        return nil
      }
    } catch {
      print(" Error while fetching the pokemons")
      return nil
    }
  }


  func deletePokemonInPokedex(withId id: Int) {

    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

    // 1
    let managedContext = appDelegate.persistentContainer.viewContext

    //2
    let fectchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonCD")

    //3
    fectchRequest.predicate = NSPredicate(format: "id == %@", "\(id)")

    //4
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fectchRequest)

    do {
      // this line does the magic
      try managedContext.execute(deleteRequest)
    } catch let error as NSError {
      print("Could not delete. \(error), \(error.userInfo)")
    }

  }// end func



  // code challenge

  func countPokemons() -> Int {
      var items: [PokemonCD]?
      guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 0}

      let managedCtx = appDelegate.persistentContainer.viewContext

      do {
          items = try managedCtx.fetch(PokemonCD.fetchRequest())

          if let items = items, !items.isEmpty {
              print("Bring count of data from CD")
              return items.count
          } else {
              return 0
          }
      } catch {
          print("Error while trying to fetch the pokemons")
      }
    return 0
  }// end func


}
