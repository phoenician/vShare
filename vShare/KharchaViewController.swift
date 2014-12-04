//
//  KharchaViewController.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 11/28/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit

class KharchaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var membersTable: UITableView!
    @IBOutlet weak var addKharchaLabel: UILabel!
    @IBOutlet weak var kharchaAmt: UITextField!
    @IBOutlet weak var kharchaDesc: UITextField!
    var eventMembers:[NSString] = []
    var kharcha:Kharcha = Kharcha()
    

    @IBAction func doneButtonClicked(sender: AnyObject) {
        var amt = (kharchaAmt.text as NSString).floatValue/Float (eventMembers.count)
        kharcha.desc = kharchaDesc.text
        kharcha.amount = amt
        kharcha.members = eventMembers
        event.kharchas.append(kharcha)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addKharchaLabel.text = "Add expense for \(eventName)"
        eventMembers = eventsDict[selectedEvent]!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return eventMembers.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "cell")
        cell.textLabel.text = eventMembers[indexPath.row]
        return cell
    }
    
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            eventMembers.removeAtIndex(indexPath.row)
            membersTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    

}
