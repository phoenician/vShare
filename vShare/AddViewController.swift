//
//  AddViewController.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 11/27/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit
import AddressBookUI


class AddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var friendName: UITextField!
    @IBOutlet weak var friendsTable: UITableView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        println("Going to save event \(newEvent.desc) to Mongo")
        //save event to DB
        asyncSave(newEvent)
    }
    
    func asyncSave(event:Event){
        ds.saveEvent(event){
            eventid in
            println("******* Event id is \(eventid) *******")
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("showListOfEvents", sender: self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        friendsTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return newEvent.members.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "cell")
        cell.textLabel?.text = newEvent.members[indexPath.row].name
        return cell
    }
    
}
