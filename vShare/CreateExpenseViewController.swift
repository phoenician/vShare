//
//  CreateExpenseViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/31/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

class CreateExpenseViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentView1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var sharersVC:SelectSharersViewController = SelectSharersViewController()
        var spendersVC:SelectSpendersViewController = SelectSpendersViewController()

        self.addChildViewController(sharersVC);
        sharersVC.view.frame = self.contentView.frame
        sharersVC.didMoveToParentViewController(self);
        
        self.addChildViewController(spendersVC)
        spendersVC.view.frame = self.contentView1.frame
        spendersVC.didMoveToParentViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
