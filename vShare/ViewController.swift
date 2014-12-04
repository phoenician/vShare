//
//  ViewController.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 10/18/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit

var eventName:NSString = ""
var friends: [NSString] = []
var events:[NSString] = []
var eventsDict = [NSString:[NSString]]()
var selectedEvent:NSString = "Nothing Selected"

var event:Event = Event()


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var eventsTable: UITableView!
    
    @IBOutlet weak var eventTextField: UITextField!
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        eventName = textField.text
        event.desc = eventName
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        events = [NSString](eventsDict.keys)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return eventsDict.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "cell")
        cell.textLabel.text = events[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedEvent = events[indexPath.row]
        self.performSegueWithIdentifier("addKharchaSegue", sender: indexPath)
    }
    
    override func viewWillAppear(animated: Bool) {
        events = [NSString](eventsDict.keys)
        eventsTable.reloadData()
    }
}

