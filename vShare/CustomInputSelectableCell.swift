//
//  CustomInputSelectableCell.swift
//  vShare
//
//  Created by Rolee Sinha on 1/20/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import UIKit

class CustomInputSelectableCell: SimpleSelectableCell, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textField.hidden = true
        textField.delegate = self
    }
    
    override func checkboxClicked(sender: CheckBox) {
        if sender.isChecked {
            textField.text = nil
            textField.hidden = false
            delegate?.checkboxChecked(self)
        }else{
            textField.hidden = true
            delegate?.checkboxUnchecked(self)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        textField.resignFirstResponder()
    }

}
