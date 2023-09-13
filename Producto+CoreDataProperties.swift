//
//  Producto+CoreDataProperties.swift
//  ejTienda3
//
//  Created by Javier Rodríguez Valentín on 01/10/2021.
//
//

import Foundation
import CoreData


extension Producto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Producto> {
        return NSFetchRequest<Producto>(entityName: "Producto")
    }

    @NSManaged public var precio: String?
    @NSManaged public var producto: String?

}

extension Producto : Identifiable {

}
