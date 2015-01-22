//
//  SimpleSelectableCell.swift
//  vShare
//
//  Created by Rolee Sinha on 1/20/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import UIKit

class SimpleSelectableCell: UITableViewCell, CheckBoxDelegate{
    
    var delegate:SimpleSelectableCellDelegate?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var checkBox: CheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkBox.delegate = self
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func checkboxClicked(sender: CheckBox) {
        if sender.isChecked {
            delegate?.checkboxChecked(self)
        }else{
            delegate?.checkboxUnchecked(self)
        }
    }

}
