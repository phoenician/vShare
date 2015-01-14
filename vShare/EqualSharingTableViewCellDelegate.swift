//
//  EqualSharingTableViewCellDelegate.swift
//  vShare
//
//  Created by Sulabh Shukla on 1/13/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import Foundation

protocol EqualSharingTableViewCellDelegate:NSObjectProtocol{
    func checkboxChecked(sender: EqualSharingTableViewCell)
    func checkboxUnchecked(sender: EqualSharingTableViewCell)
}