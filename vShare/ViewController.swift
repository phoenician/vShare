//
//  ViewController.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 10/18/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit
import QuartzCore

var myid = usrDefaults.objectForKey("userid") as NSString

var events:[Event] = []
var selectedEvent:Event?

var newEvent:Event = Event()

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var eventsTable: UITableView!
    @IBOutlet weak var eventTextField: UITextField!
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        newEvent.desc = textField.text
        let user:Participant = Participant(id: myid, name: usrDefaults.objectForKey("name") as String, code: usrDefaults.objectForKey("countrycode") as String, phone: usrDefaults.objectForKey("phone") as String)
        newEvent.members.append(user)
        textField.resignFirstResponder()
        return true
    }
    
    func reinitializeView(){
        events = []
        eventTextField.text = nil
        asyncFetchTableData()
        eventsTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reinitializeView()
    }
    
    func asyncFetchTableData(){
        ds.getEvents(usrDefaults.objectForKey("userid") as NSString){
            eventsList in
            for event in eventsList {
                events.append(event)
            }
            dispatch_async(dispatch_get_main_queue()) {
                self.eventsTable.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "eventcell")
        var labelText = events[indexPath.row].desc
        cell.textLabel?.text = labelText
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedEvent = events[indexPath.row]
        self.performSegueWithIdentifier("showEventView", sender: indexPath)
    }
    
    @IBAction func cancelToViewController(segue: UIStoryboardSegue) {
        reinitializeView()
    }
    
}

