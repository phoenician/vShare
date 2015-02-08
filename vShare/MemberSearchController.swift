//
//  MemberSearchController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/12/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit
import CoreData

var eventMembers:[Participant] = []

class MemberSearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SimpleSelectableCellDelegate {

    var participants:[Participant] = []
    
    @IBOutlet weak var memberSearchBar: UISearchBar!
    @IBOutlet weak var memberTable: UITableView!
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        newEvent.members+=eventMembers
        self.performSegueWithIdentifier("cancelToAddViewController", sender: self)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        if(searchBar.selectedScopeButtonIndex == 0){
            var usersFromCoreData:[Participant] = ps.getParticipantsFromCoreDataMatchName(searchBar.text)
            ds.searchParticipants("name", searchstr: searchBar.text, callback: {
                usersFromDB in
                dispatch_async(dispatch_get_main_queue()) {
                    self.participants = usersFromCoreData + usersFromDB
                    self.memberTable.reloadData()
                }
            })
        }else if(searchBar.selectedScopeButtonIndex == 1){
            var usersFromCoreData:[Participant] = ps.getParticipantsFromCoreDataMatchPhone(searchBar.text)
            ds.searchParticipants("phone", searchstr: searchBar.text, callback: {
                usersFromDB in
                dispatch_async(dispatch_get_main_queue()) {
                    self.participants = usersFromCoreData + usersFromDB
                    self.memberTable.reloadData()
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return participants.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell:SimpleSelectableCell = tableView.dequeueReusableCellWithIdentifier("selectmembercell") as SimpleSelectableCell
        cell.nameLabel.text = participants[indexPath.row].name!
        cell.phoneLabel.text = participants[indexPath.row].phone!
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func checkboxChecked(sender: SimpleSelectableCell){
        eventMembers.append(participants[sender.tag])
    }
    
    func checkboxUnchecked(sender: SimpleSelectableCell){
        var toremove:Participant = participants[sender.tag]
        eventMembers = eventMembers.filter{
            participant -> Bool in
            if (toremove.name != participant.name || toremove.countrycode != participant.countrycode || toremove.phone != participant.phone){
                return true
            }
            return false
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        eventMembers = []
        participants = ps.getAllParticipantsFromCoreData()
        memberSearchBar.text = ""
        memberTable.reloadData()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        memberSearchBar.resignFirstResponder()
    }
}
