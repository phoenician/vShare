//
//  SpendersTableViewCell.swift
//  vShare
//
//  Created by Rolee Sinha on 1/9/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import UIKit

class SpendersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var amountField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
