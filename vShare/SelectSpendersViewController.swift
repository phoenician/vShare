//
//  SelectSpendersViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/31/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

class SelectSpendersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var selector: UISegmentedControl!
    @IBOutlet weak var spendersTable: UITableView!
    
    var spenders:[Participant] = selectedEvent!.members
    
    @IBAction func selected(sender: AnyObject) {
        if(selector.selectedSegmentIndex == 0) {
            spendersTable.hidden = true
        }else{
            spendersTable.hidden = false
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spendersTable.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return spenders.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:MembersTableViewCell = tableView.dequeueReusableCellWithIdentifier("mycell") as MembersTableViewCell
        cell.detailLabel.text = "\(spenders[indexPath.row].name!) \(spenders[indexPath.row].countrycode!) - \(spenders[indexPath.row].phone!)"
        cell.addButton.tag = indexPath.row
        cell.addButton.backgroundColor = UIColor.greenColor()
        cell.addButton.setTitle("Add", forState: UIControlState.Normal)
        cell.addButton.addTarget(self, action: "cellButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        
        return cell
    }
}
