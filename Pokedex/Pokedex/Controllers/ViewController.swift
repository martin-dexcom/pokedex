//
//  ViewController.swift
//  Pokedex
//
//  Created by Martin García on 7/12/21.
//

import UIKit
import CoreData

class ViewController: UIViewController  {


  @IBOutlet weak var collectionView: UICollectionView!

    // Reference to managed object context
    let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext //NSManagedObject()


    // data for the CollectionView
    var items: [PokemonCD]?



    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        //collectionView.delegate = self
        //collectionView.dataSource = self

        // First review stored data
        // get items from Core Data
        if !fetchPokemons() {

        // bring data from network
        print("bring data from network")
        let network = NetworkManager()
        network.getAllPokemons(completion: { data in
          print(data)
        })
        // test
        network.getPokemon(withName: "bulbasaur", completion: { data in
          print(data)
        })
        // by ID
          network.getPokemon(byId: 12, completion: { data in
            print(data)
          })
      }

    }

    // MARK: - Private methods
    func fetchPokemons() -> Bool {
         // fetch the data from core data to display in the tableview
         do {
          self.items = try context?.fetch(PokemonCD.fetchRequest())
          if let items = self.items, !items.isEmpty {
              // bring data from Core Data
              print("bring data from Core Data")
              DispatchQueue.main.async{
                  // TODO create the collectio view, then uncomment next line
                  // self.collectionView.reloadData()
                print("trying to relad data for collection view")
              }
          } else {
            return false
          }


         } catch  {
             print(" error on fetch the pokemons")
         }
      return true
     }


      // MARK: - IBActions
      @IBAction func addTapped(_ sender: Any){

        // TODO retrieve information from the sender

        // create a new Pokemon object
        // this is how we interact with the context
        let newPokemonCoreData = PokemonCD(context: self.context!)
        newPokemonCoreData.name = "Un pikachu"
        newPokemonCoreData.id = 12
        newPokemonCoreData.stat = 60
        newPokemonCoreData.type = "Electric"
        newPokemonCoreData.image = "a URL for an image"

        // TODO save the data
        do {
            try self.context?.save()
        } catch {
            print("unable to save data")
        }

        // TODO refresh the data
        _ = self.fetchPokemons()

      }

      func deletePokemon() {

        // TODO wich Pokemon to remove from the collection view
        // let personToRemove = self.items![indexPath.row]
        let pokemonToRemove = self.items![1]

        // TODO remove the person
        self.context?.delete(pokemonToRemove)

        // TODO save the data
        do {
            try self.context?.save()
        } catch {
            print("Unable to delete a Pokemon")
        }

        // TODO re-fecth the data
        _ = self.fetchPokemons()

      }



}

// MARK: - Extensions
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }



}

