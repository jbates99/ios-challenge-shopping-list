//
//  Item.swift
//  ShoppingList
//
//  Created by Joshua Bates on 5/17/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData


class Item: NSManagedObject {

    convenience init(name: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        guard let entity = NSEntityDescription.entityForName("Item", inManagedObjectContext: context) else { fatalError("item not found") }
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.name = name
    }

}
