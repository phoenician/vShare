//
//  KharchaViewController.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 11/28/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit

class KharchaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var kharchaMembers:[Participant] = []
    
    @IBOutlet weak var membersTable: UITableView!
    @IBOutlet weak var kharchaAmt: UITextField!
    @IBOutlet weak var kharchaDesc: UITextField!
    //var eventMembers:[NSString] = []
    var kharcha:Kharcha = Kharcha()
    
    @IBAction func donePressed(sender: AnyObject) {
        kharcha.desc = kharchaDesc.text
        kharcha.amount = (kharchaAmt.text as NSString).floatValue/Float (kharcha.participants.count)
        kharcha.eventId = selectedEvent?.id
        kharcha.creator = usrDefaults.objectForKey("userid") as? NSString
        asyncSave(kharcha)
    }
    
    func asyncSave(kharcha:Kharcha) {
        ds.saveExpense(kharcha){
            id in
            self.kharcha.id = id
            selectedEvent?.kharchas.append(self.kharcha)
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("showExpFromAddExp", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kharcha.participants = selectedEvent!.members
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return kharcha.participants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "cell")
            cell.textLabel.text = kharcha.participants[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            kharcha.participants.removeAtIndex(indexPath.row)
            membersTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        kharchaAmt.resignFirstResponder()
        kharchaDesc.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
