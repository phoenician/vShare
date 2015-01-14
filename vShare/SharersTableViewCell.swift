//
//  SharersTableViewCell.swift
//  vShare
//
//  Created by Rolee Sinha on 1/12/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import UIKit

class SharersTableViewCell: UITableViewCell, UITextFieldDelegate, CheckBoxDelegate {
    
    var delegate:SharersTableViewCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var checkbox: CheckBox!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func checkboxClicked(sender: CheckBox) {
        if sender.isChecked {
            amountTextField.text = nil
            amountTextField.hidden = false
            delegate?.checkboxChecked(self)
        }else{
            amountTextField.hidden = true
            delegate?.checkboxUnchecked(self)
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        if delegate != nil {
            return delegate!.textFieldShouldReturn(self)
        }
        return false
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        amountField.resignFirstResponder()
        textFieldShouldReturn(amountField)
    }

}
