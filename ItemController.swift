//
//  ItemController.swift
//  ShoppingList
//
//  Created by Joshua Bates on 5/17/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    static let sharedController = ItemController()
    private let itemKey = "items"
    
    var items: [Item] {
        let request = NSFetchRequest(entityName: "Item")
        let moc = Stack.sharedStack.managedObjectContext
        let result = (try? moc.executeFetchRequest(request)) as? [Item]
        return result ?? []
    }
    
    func addItem(name: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        let _ = Item(name: name, context: context)
        saveToPersistentStorage()
    }
    
    func removeItem(item: Item) {
        if let moc = item.managedObjectContext {
            moc.deleteObject(item)
            saveToPersistentStorage()
        }
    }
    
    func saveToPersistentStorage() {
        _ = try? Stack.sharedStack.managedObjectContext.save()
    }
}
