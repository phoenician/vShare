//
//  MemberSearchController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/12/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var eventMembers:[Participant] = []

class MemberSearchController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    let ps:ParticipantService = ParticipantService()
    var participants:[Participant] = []
    
    @IBOutlet weak var memberSearchBar: UISearchBar!
    @IBOutlet weak var memberTable: UITableView!
    
    @IBAction func doneButtonClicked(sender: AnyObject) {
        newEvent.members+=eventMembers
        self.performSegueWithIdentifier("backToNewEvent", sender: self)
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
        var cell:MembersTableViewCell = tableView.dequeueReusableCellWithIdentifier("mycell") as MembersTableViewCell
        cell.detailLabel.text = "\(participants[indexPath.row].name!) \(participants[indexPath.row].countrycode!) - \(participants[indexPath.row].phone!)"
        cell.addButton.tag = indexPath.row
        cell.addButton.backgroundColor = UIColor.greenColor()
        cell.addButton.setTitle("Add", forState: UIControlState.Normal)
        cell.addButton.addTarget(self, action: "cellButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
    
    func cellButtonClicked(sender:UIButton!){
        if let label = sender.titleLabel{
            if label.text == "Add" {
                sender.setTitle("Remove", forState: UIControlState.Normal)
                sender.backgroundColor = UIColor.redColor()
                eventMembers.append(participants[sender.tag])
            }
            else {
                var toremove:Participant = participants[sender.tag]
                sender.setTitle("Add", forState: UIControlState.Normal)
                sender.backgroundColor = UIColor.greenColor()
                eventMembers = eventMembers.filter{
                    participant -> Bool in
                    if (toremove.name != participant.name || toremove.countrycode != participant.countrycode || toremove.phone != participant.phone){
                        return true
                    }
                    return false
                }
            }
        }
        println("Following are the event members: --")
        for p in eventMembers {
            println(p.name)
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
