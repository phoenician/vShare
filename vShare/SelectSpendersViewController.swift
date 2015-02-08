//
//  SelectSpendersViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/31/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var spendersDict:[Participant:Float] = [:]


class SelectSpendersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SimpleSelectableCellDelegate {

    @IBOutlet weak var selector: UISegmentedControl!
    @IBOutlet weak var spendersTable: UITableView!
    @IBOutlet weak var nextActionButton: UIButton!

    var cellsDict:[NSNumber:CustomInputSelectableCell] = [:]
    var all:[Participant] = selectedEvent!.members
    
    @IBAction func selected(sender: AnyObject) {
        if(selector.selectedSegmentIndex == 0) {
            spendersTable.hidden = true
            nextActionButton.setTitle("Let's move along", forState: UIControlState.Normal)
        }else{
            spendersTable.hidden = false
            nextActionButton.hidden = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spendersDict = [:]
        spendersTable.hidden = true
        nextActionButton.setTitle("Let's move along", forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return all.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:CustomInputSelectableCell = tableView.dequeueReusableCellWithIdentifier("selectspendercell") as CustomInputSelectableCell
        cell.nameLabel.text = all[indexPath.row].name!
        cell.phoneLabel.text = all[indexPath.row].phone!
        cell.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    
    func checkboxUnchecked(cell: SimpleSelectableCell) {
        cellsDict[cell.tag] = nil
    }
    
    func checkboxChecked(cell: SimpleSelectableCell) {
        if nextActionButton.hidden == true {
            nextActionButton.setTitle("Done adding spenders", forState: UIControlState.Normal)
            nextActionButton.hidden = false
        }
        cellsDict[cell.tag] = cell as? CustomInputSelectableCell
    }
    
    func reset(){
        cellsDict = [:]
        spendersDict = [:]
    }

    @IBAction func nxtActionClicked(sender: UIButton) {
        if selector.selectedSegmentIndex == 0 {
            spendersDict[ps.getPrincipal()!] = expense.amount
        }else{
            //build spenders dict and reinitialize cells dict
            for (tag, cell) in cellsDict{
                spendersDict[all[Int(tag)]] = (cell.textField.text as NSString).floatValue
            }
        }
        expense.spenders = spendersDict
        reset()
        self.performSegueWithIdentifier("fromSpendersToSharers", sender: self)
    }
}
