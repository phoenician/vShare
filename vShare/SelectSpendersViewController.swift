//
//  SelectSpendersViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/31/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var spendersDict:[Participant:Float] = [:]


class SelectSpendersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, LabelCheckboxTableViewCellDelegate {

    @IBOutlet weak var selector: UISegmentedControl!
    @IBOutlet weak var spendersTable: UITableView!
    @IBOutlet weak var nextActionButton: UIButton!

    var all:[Participant] = selectedEvent!.members
    
    @IBAction func selected(sender: AnyObject) {
        if(selector.selectedSegmentIndex == 0) {
            spendersTable.hidden = true
            nextActionButton.setTitle("Let's move along", forState: UIControlState.Normal)
            nextActionButton.hidden = false
        }else{
            spendersTable.hidden = false
            nextActionButton.hidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spendersTable.hidden = true
        nextActionButton.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return all.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:LabelCheckboxTableViewCell = tableView.dequeueReusableCellWithIdentifier("selectspendercell") as LabelCheckboxTableViewCell
        cell.nameLabel.text = "\(all[indexPath.row].name!)"
        cell.phoneLabel.text = "\(all[indexPath.row].phone!)"
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func textFieldShouldReturn(cell: LabelCheckboxTableViewCell) -> Bool{
        spendersDict[all[cell.tag]] = (cell.amountTextField.text as NSString).floatValue
        return true
    }
    
    func checkboxUnchecked(cell: LabelCheckboxTableViewCell) {
        spendersDict[all[cell.tag]] = nil
    }
    
    func checkboxChecked(sender: LabelCheckboxTableViewCell) {
        if nextActionButton.hidden == true {
            nextActionButton.setTitle("Done adding spenders", forState: UIControlState.Normal)
            nextActionButton.hidden = false
        }
    }

    @IBAction func nxtActionClicked(sender: UIButton) {
        if selector.selectedSegmentIndex == 0 {
            spendersDict[ps.getParticipantById(selectedExpense.creator!)!] = selectedExpense.amount
        }
        expense.spenders = spendersDict
        self.performSegueWithIdentifier("fromSpendersToSharers", sender: self)
    }
}
