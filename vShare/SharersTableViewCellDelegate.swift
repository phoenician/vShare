//
//  SharersTableViewCellDelegate.swift
//  vShare
//
//  Created by Rolee Sinha on 1/12/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import Foundation

protocol SharersTableViewCellDelegate: NSObjectProtocol{
    func textFieldShouldReturn(sender: SharersTableViewCell) -> Bool
    func checkboxChecked(sender: SharersTableViewCell)
    func checkboxUnchecked(sender: SharersTableViewCell)
    func stepperValueChanged(sender: SharersTableViewCell)
}
