//
//  PokemonCD+CoreDataProperties.swift
//  Pokedex
//
//  Created by Josué Arambula on 7/17/21.
//
//

import Foundation
import CoreData


extension PokemonCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonCD> {
        return NSFetchRequest<PokemonCD>(entityName: "PokemonCD")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var stat: Int64
    @NSManaged public var type: String?

}

extension PokemonCD : Identifiable {

}
