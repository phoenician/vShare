//
//  CheckBox.swift
//  vShare
//
//  Created by Rolee Sinha on 1/9/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    
    var delegate:CheckBoxDelegate?
    
    let checkedImg = UIImage(named: "checkbox_full")
    let uncheckedImg = UIImage(named: "checkbox_empty")
    
    var isChecked:Bool = false{
        didSet{
            if isChecked {
                self.setImage(checkedImg, forState: .Normal)
            }else{
                self.setImage(uncheckedImg, forState: .Normal)
            }
        }
    }

    override func awakeFromNib(){
        self.isChecked = false
        self.addTarget(self, action: "checkboxClicked:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func checkboxClicked(sender:CheckBox!){
        if sender == self{
            if isChecked {
                isChecked = false
            }else{
                isChecked = true
            }
            delegate?.checkboxClicked(sender)
        }
    }

}
