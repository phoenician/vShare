//
//  WeightedInputSelectableCell.swift
//  vShare
//
//  Created by Rolee Sinha on 1/20/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import UIKit

class WeightedInputSelectableCell: SimpleSelectableCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    var weight:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.countLabel.hidden = true
        
        //TODO: this needs to change - should default to the number of family members in a participants family (configured while creating event)
        self.countLabel.text = "1"
        self.stepper.hidden = true
        self.stepper.wraps = true
        self.stepper.autorepeat = true
        self.stepper.minimumValue = 1
        self.stepper.maximumValue = 20
    }
    
    @IBAction func stepperValueChanged(sender: UIStepper) {
        weight = Int(sender.value)
        self.countLabel.text = Int(sender.value).description
    }
    
    override func checkboxClicked(sender: CheckBox) {
        if sender.isChecked {
            self.countLabel.hidden = false
            self.stepper.hidden = false
            delegate?.checkboxChecked(self)
        }else{
            self.countLabel.hidden = true
            self.stepper.hidden = true
            delegate?.checkboxUnchecked(self)
        }
    }
    
}
