//
//  SelectSharersViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/31/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var sharers:[Participant] = []

class SelectSharersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EqualSharingTableViewCellDelegate{
    
    @IBOutlet weak var nextActionButton: UIButton!
    @IBOutlet weak var sharingTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sharersTable: UITableView!
    
    var all:[Participant] = selectedEvent!.members
    var tags:[NSNumber] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sharers = all
        nextActionButton.hidden = true
        sharersTable.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        sharersTable.reloadData()
        sharersTable.hidden = false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return all.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        if sharingTypeSegmentedControl.selectedSegmentIndex == 0 {
            var cell:EqualSharingTableViewCell = tableView.dequeueReusableCellWithIdentifier("selectequalsharercell") as EqualSharingTableViewCell
            cell.nameLabel.text = "\(all[indexPath.row].name!)"
            cell.phoneLabel.text = "\(all[indexPath.row].phone!)"
            cell.tag = indexPath.row
            cell.delegate = self
            return cell
        }
        else{
            var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
                , reuseIdentifier: "cell")
            cell.textLabel?.text = "\(all[indexPath.row].name!)"
            return cell
        }
    }
    
    func checkboxUnchecked(cell: EqualSharingTableViewCell) {
        tags = tags.filter({$0 != cell.tag})
    }
    
    func checkboxChecked(sender: EqualSharingTableViewCell) {
        if nextActionButton.hidden == true {
            nextActionButton.setTitle("Done adding spenders", forState: UIControlState.Normal)
            nextActionButton.hidden = false
        }
    }
    
}
