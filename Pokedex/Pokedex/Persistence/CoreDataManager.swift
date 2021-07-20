//
//  CoreDataManager.swift
//  Pokedex
//
//  Created by Josué Arambula on 7/19/21.
//

import UIKit
import CoreData


protocol CoreDataCrudProtocol {
    
    func savePokemonInPokedex(pokemon: Pokemon)
    func deletePokemonInPokedex(withId id: Int)
    func fetchPokemons() -> [PokemonCD]?
    func countPokemons() -> Int
}


class CoreDataManager: CoreDataCrudProtocol {
    static let shared = CoreDataManager()

    
    func countPokemons() -> Int {
        
        var items: [PokemonCD]?
        
        // as we know the container is setup in the AppDelegate, so we need to refer that container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return 0 }
        
        // we need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        // fetch the data from core data to display in the tableview
        do {
            items = try managedContext.fetch(PokemonCD.fetchRequest())
            if let items = items, !items.isEmpty {
                // bring data from Core Data
                print("Elements in db: \(items.count)")
                
                return items.count
            } else {
                print(" Data base is emtpy")
                return 0
            }
        } catch  {
            print(" error on fetch the pokemons")
            return 0
        }
        
    }
    
    
    
    /// The process of adding the records to Core Data has following tasks
    /// * Refer to persistentContainer from appdelegate
    /// * Create the context from persistentContainer
    /// * Create an entity with User
    /// * Create new record with this User Entity
    /// * Set values for the records for each key
    func savePokemonInPokedex(pokemon: Pokemon) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "PokemonCD", in: managedContext)!
        
        // 3
        let pokemonObject = NSManagedObject(entity: entity, insertInto: managedContext)
        
        
        pokemonObject.setValue(pokemon.id, forKeyPath: "id")
        pokemonObject.setValue(pokemon.sprites?.frontDefault, forKey: "image")
        pokemonObject.setValue(pokemon.name, forKey: "name")
        pokemonObject.setValue(0, forKey: "stat")
        pokemonObject.setValue(pokemon.types?.first?.type?.name, forKey: "type")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    
    /// Batch update or delete
    /// For delete record first we have to find object which we want to delete by fetchRequest. then follow below few steps for delete record
    /// * Prepare the request with predicate for the entity (User in our example)
    /// * Fetch record and which we want to delete
    /// * And make context.delete(object) call (ref image attached below)
    func deletePokemonInPokedex(withId id: Int) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PokemonCD")
        
        // by id which is the forKeyPath
        fetchRequest.predicate = NSPredicate(format: "id == %@", "\(id)")
        
        // 3
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        // 4
        do {
            try managedContext.execute(deleteRequest)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    
    
    /// Retrieve Data
    /// Prepare the request of type NSFetchRequest for the entity (User in our example)
    /// if required use predicate for filter data
    /// Fetch the result from context in the form of array of [NSManagedObject]
    /// Iterate through an array to get value for the specific key (if need it)
    func fetchPokemons() -> [PokemonCD]? {
        
        // data for the TableView
        var items: [PokemonCD]?
        
        // as we know the container is setup in the AppDelegate, so we need to refer that container
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        // we need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        // fetch the data from core data to display in the tableview
        do {
            items = try managedContext.fetch(PokemonCD.fetchRequest())
            if let items = items, !items.isEmpty {
                // bring data from Core Data
                print("bring data from Core Data")
                return items
            } else {
                return nil
            }
        } catch  {
            print(" error on fetch the pokemons")
            return nil
        }
    }
    
    
    
    
}
