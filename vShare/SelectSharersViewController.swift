//
//  SelectSharersViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/31/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var sharersDict:[Participant:Float] = [:]

class SelectSharersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EqualSharingTableViewCellDelegate, WeightedSharingTableViewCellDelegate, LabelCheckboxTableViewCellDelegate{
    
    @IBOutlet weak var nextActionButton: UIButton!
    @IBOutlet weak var sharingTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sharersTable: UITableView!
    
    var all:[Participant] = selectedEvent!.members
    
    var cumulativeWeight:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextActionButton.hidden = true
        sharersTable.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        sharersDict = [:]
        cumulativeWeight = 0
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
        if sharingTypeSegmentedControl.selectedSegmentIndex == 2 {
            var cell:LabelCheckboxTableViewCell = tableView.dequeueReusableCellWithIdentifier("selectcustomsharercell") as LabelCheckboxTableViewCell
            cell.nameLabel.text = "\(all[indexPath.row].name!)"
            cell.phoneLabel.text = "\(all[indexPath.row].phone!)"
            cell.tag = indexPath.row
            cell.delegate = self
            return cell
        }
        else{
            var cell:WeightedSharingTableViewCell = tableView.dequeueReusableCellWithIdentifier("selectweightedsharercell") as WeightedSharingTableViewCell
            cell.nameLabel.text = "\(all[indexPath.row].name!)"
            cell.phoneLabel.text = "\(all[indexPath.row].phone!)"
            cell.tag = indexPath.row
            cell.delegate = self
            return cell
        }
    }

    func checkboxUnchecked(cell: WeightedSharingTableViewCell) {
        sharersDict[all[cell.tag]] = nil
    }
    
    func checkboxChecked(sender: WeightedSharingTableViewCell) {
        if nextActionButton.hidden == true {
            nextActionButton.setTitle("Done adding sharing details", forState: UIControlState.Normal)
            nextActionButton.hidden = false
        }
    }
    
    func weightChanged(sender: WeightedSharingTableViewCell) {
        sharersDict[all[sender.tag]] = Float(sender.stepper.value)
    }
    
    func checkboxUnchecked(cell: EqualSharingTableViewCell) {
        sharersDict[all[cell.tag]] = nil
    }
    
    func checkboxChecked(sender: EqualSharingTableViewCell) {
        if nextActionButton.hidden == true {
            nextActionButton.setTitle("Done adding sharing details", forState: UIControlState.Normal)
            nextActionButton.hidden = false
        }
        sharersDict[all[sender.tag]] = 0
    }
    
    func textFieldShouldReturn(cell: LabelCheckboxTableViewCell) -> Bool{
        sharersDict[all[cell.tag]] = (cell.amountTextField.text as NSString).floatValue
        return true
    }
    
    func checkboxUnchecked(cell: LabelCheckboxTableViewCell) {
        sharersDict[all[cell.tag]] = nil
    }
    
    func checkboxChecked(sender: LabelCheckboxTableViewCell) {
        if nextActionButton.hidden == true {
            nextActionButton.setTitle("Done adding sharing details", forState: UIControlState.Normal)
            nextActionButton.hidden = false
        }
    }
    
    @IBAction func nxtActionClicked(sender: UIButton) {
        println("printing contents of sharers dictionary:  ")
        for (k, v) in sharersDict{
            cumulativeWeight += Int(v)
            println("Sharer is \(k.name) cumulative weight is \(cumulativeWeight) ")
        }
        var unitAmt:Float = expense.amount!/Float(cumulativeWeight)
        if sharingTypeSegmentedControl.selectedSegmentIndex == 0{
            for (k, v) in sharersDict{
                sharersDict[k] = unitAmt
            }
        }
        if sharingTypeSegmentedControl.selectedSegmentIndex == 1{
            for (k, v) in sharersDict{
                sharersDict[k] = v*unitAmt
            }
        }
        expense.sharers = sharersDict
        asyncSave(expense)
    }
    
    func asyncSave(kharcha:Kharcha) {
        ds.saveExpense(kharcha){
            id in
            expense.id = id
            selectedEvent?.kharchas.append(expense)
            dispatch_async(dispatch_get_main_queue()) {
                self.performSegueWithIdentifier("fromSharersToEventView", sender: self)
            }
        }
    }
    
}
