//
//  SimpleSelectableCellDelegate.swift
//  vShare
//
//  Created by Rolee Sinha on 1/20/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import Foundation

protocol SimpleSelectableCellDelegate:NSObjectProtocol{
    func checkboxChecked(sender: SimpleSelectableCell)
    func checkboxUnchecked(sender: SimpleSelectableCell)
}
