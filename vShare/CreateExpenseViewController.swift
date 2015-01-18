//
//  CreateExpenseViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/31/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var expense:Kharcha = Kharcha()

class CreateExpenseViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    @IBAction func donePressed(sender: AnyObject) {
        expense.eventId = selectedEvent!.id
        expense.creator = usrDefaults.objectForKey("userid") as? NSString
        expense.desc = desc.text
        expense.amount = (amount.text as NSString).floatValue
        self.performSegueWithIdentifier("selectSpendersSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        amount.hidden = true
        doneButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        amount.resignFirstResponder()
        if (!desc.text.isEmpty && !amount.text.isEmpty){
            doneButton.enabled = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        if (!desc.text.isEmpty && amount.hidden == true){
            amount.hidden = false
        }
        return true
    }
}
