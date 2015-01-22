//
//  MemberSearchController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/12/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var eventMembers:[Participant] = []

class MemberSearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, SimpleSelectableCellDelegate {

    let ps:ParticipantService = ParticipantService()
    var participants:[Participant] = []
    
    @IBOutlet weak var memberSearchBar: UISearchBar!
    @IBOutlet weak var memberTable: UITableView!
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        newEvent.members+=eventMembers
        self.performSegueWithIdentifier("cancelToAddViewController", sender: self)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if searchBar.text.isEmpty{
            participants = ps.userdb
        }else{
            participants = ps.getMatchingParticipants(Participant(name: searchBar.text, code: "", phone: ""))
        }
        memberTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        participants = ps.userdb
        // Do any additional setup after loading the view.
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
        participants = ps.userdb
        memberSearchBar.text = ""
        memberTable.reloadData()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        memberSearchBar.resignFirstResponder()
    }
}
