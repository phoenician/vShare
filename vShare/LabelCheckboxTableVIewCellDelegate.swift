//
//  LabelCheckboxTableVIewCellDelegate.swift
//  vShare
//
//  Created by Rolee Sinha on 1/11/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import Foundation

protocol LabelCheckboxTableViewCellDelegate: NSObjectProtocol{
    func textFieldShouldReturn(sender: LabelCheckboxTableViewCell) -> Bool
    func checkboxChecked(sender: LabelCheckboxTableViewCell)
    func checkboxUnchecked(sender: LabelCheckboxTableViewCell)
}
