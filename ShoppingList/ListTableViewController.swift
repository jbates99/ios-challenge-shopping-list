//
//  ListTableViewController.swift
//  ShoppingList
//
//  Created by Joshua Bates on 5/17/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, ListTableViewCellDelegate {
    

    @IBAction func addButtonTapped(sender: AnyObject) {
        let alertController = UIAlertController(title: "Add Item", message: "Please add an item to your shopping list", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (addItem) in
            if let name = alertController.textFields?[0].text {
            ItemController.sharedController.addItem(name)
            self.tableView.reloadData()
            }
        }))
        
        alertController.addTextFieldWithConfigurationHandler({ (textField) in
            textField.placeholder = "Enter Item Name"
        })
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }
    
    func ListCellButtonTapped(sender: ListTableViewCell) {
        
        if let index = tableView.indexPathForCell(sender) {
            let item = ItemController.sharedController.items[index.row]
            if item.isComplete == true {
                item.isComplete = false
            } else {
                item.isComplete = true
            }
            ItemController.sharedController.saveToPersistentStorage()
        }
        tableView.reloadData()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.sharedController.items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("listViewCell", forIndexPath: indexPath) as? ListTableViewCell {
            
            cell.delegate = self
            cell.updateWithItem(ItemController.sharedController.items[indexPath.row])
        
        return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let item = ItemController.sharedController.items[indexPath.row]
            ItemController.sharedController.removeItem(item)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            ItemController.sharedController.saveToPersistentStorage()
        }    
    }

}
