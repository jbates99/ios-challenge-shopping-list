//
//  ListTableViewCell.swift
//  ShoppingList
//
//  Created by Joshua Bates on 5/17/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet var button: UIButton!
    @IBOutlet var primaryLabel: UILabel!
    
    weak var delegate: ListTableViewCellDelegate?
    
    @IBAction func buttonTapped(sender: AnyObject) {
        if delegate != nil {
            delegate?.ListCellButtonTapped(self)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension ListTableViewCell {
    func updateButton(isComplete: Bool) {
        if isComplete {
            button.setImage(UIImage(named: "complete"), forState: .Normal)
        } else {
            button.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }
    
    func updateWithItem(item: Item) {
        primaryLabel.text = item.name
        updateButton(item.isComplete!.boolValue)
    }
}

protocol ListTableViewCellDelegate: class {
    func ListCellButtonTapped(sender: ListTableViewCell)
}
