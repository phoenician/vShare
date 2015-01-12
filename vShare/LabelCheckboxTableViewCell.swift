//
//  LabelCheckboxTableViewCell.swift
//  vShare
//
//  Created by Rolee Sinha on 1/10/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import UIKit

class LabelCheckboxTableViewCell: UITableViewCell, UITextFieldDelegate, CheckBoxDelegate {

    var delegate:LabelCheckboxTableViewCellDelegate?
    
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var checkBox: CheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.amountTextField.hidden = true
        //self.checkBox.addTarget(self, action: "reactOnClick:", forControlEvents: UIControlEvents.TouchUpInside)
        self.checkBox.delegate = self
        self.amountTextField.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func reactOnClick(sender:LabelCheckboxTableViewCell!){
        if sender.checkBox.isChecked {
            amountTextField.hidden = false
        }else{
            amountTextField.hidden = true
        }
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
        amountTextField.resignFirstResponder()
        textFieldShouldReturn(amountTextField)
    }
}
