//
//  AddViewController.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 11/27/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit
import AddressBookUI


class AddViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ABPeoplePickerNavigationControllerDelegate {
    
    @IBOutlet weak var eventNameLabel: UILabel!
    
    @IBOutlet weak var friendName: UITextField!
    
    @IBOutlet weak var friendsTable: UITableView!
    
    let personPicker: ABPeoplePickerNavigationController
    
    @IBAction func addMembers(sender: AnyObject) {
        self.presentViewController(personPicker, animated: true, completion: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        personPicker = ABPeoplePickerNavigationController()
        super.init(coder: aDecoder)
        personPicker.peoplePickerDelegate = self
    }
    
    func peoplePickerNavigationController(peoplePicker: ABPeoplePickerNavigationController!, didSelectPerson person: ABRecord!) {
        if peoplePicker != personPicker {
            return
        }
        
        //let phones:ABMultiValueRef = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
        let fname:ABMultiValueRef = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue()
        
        friends.append(fname as NSString)
        friendsTable.reloadData()
        /**let count = ABMultiValueGetCount(phones)
        for i in 0..<count{
            let phone = ABMultiValueCopyValueAtIndex(phones, i).takeRetainedValue() as String
            println(phone)
        }**/
    }
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        eventsDict[eventName] = friends
        event.members = friends
        friends = []
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        eventNameLabel.text = eventName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "cell")
        cell.textLabel.text = friends[indexPath.row]
        return cell
    }
    
}
