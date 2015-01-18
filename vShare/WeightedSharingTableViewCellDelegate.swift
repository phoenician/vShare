//
//  WeightedSharingTableViewCellDelegate.swift
//  vShare
//
//  Created by Rolee Sinha on 1/13/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import Foundation

protocol WeightedSharingTableViewCellDelegate:NSObjectProtocol{
    func checkboxChecked(sender: WeightedSharingTableViewCell)
    func checkboxUnchecked(sender: WeightedSharingTableViewCell)
    func weightChanged(sender:WeightedSharingTableViewCell)
    
}