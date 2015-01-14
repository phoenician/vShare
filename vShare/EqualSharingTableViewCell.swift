//
//  EqualSharingTableViewCell.swift
//  vShare
//
//  Created by Sulabh Shukla on 1/13/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import UIKit

class EqualSharingTableViewCell: UITableViewCell, UITextFieldDelegate, CheckBoxDelegate {
    
    var delegate:EqualSharingTableViewCellDelegate?
    
    @IBOutlet weak var checkbox: CheckBox!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.checkbox.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func checkboxClicked(sender: CheckBox) {
        if sender.isChecked {
            delegate?.checkboxChecked(self)
        }else{
            delegate?.checkboxUnchecked(self)
        }
    }
 
}
