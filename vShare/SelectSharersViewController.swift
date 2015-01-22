//
//  SelectSharersViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/31/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var sharersDict:[Participant:Float] = [:]

class SelectSharersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, SimpleSelectableCellDelegate{
    
    @IBOutlet weak var nextActionButton: UIButton!
    @IBOutlet weak var sharingTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var sharersTable: UITableView!
    
    var all:[Participant] = selectedEvent!.members
    var cellsDict:[NSNumber:SimpleSelectableCell] = [:]
    
    var cumulativeWeight:Int = 0
    
    func reset(){
        cellsDict = [:]
        sharersDict = [:]
        cumulativeWeight = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextActionButton.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func segmentValueChanged(sender: UISegmentedControl) {
        reset()
        sharersTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return all.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:SimpleSelectableCell
        var segment:Int = sharingTypeSegmentedControl.selectedSegmentIndex
        switch segment  {
            case 1: cell = tableView.dequeueReusableCellWithIdentifier("selectweightedsharercell") as WeightedInputSelectableCell
            case 2: cell = tableView.dequeueReusableCellWithIdentifier("selectcustomsharercell") as CustomInputSelectableCell
            default: cell = tableView.dequeueReusableCellWithIdentifier("selectequalsharercell") as SimpleSelectableCell
        }
        setupCommonCellProperties(cell, idx: indexPath.row)
        return cell
    }
    
    func setupCommonCellProperties(cell:SimpleSelectableCell, idx:Int){
        cell.nameLabel.text = all[idx].name!
        cell.phoneLabel.text = all[idx].phone!
        cell.tag = idx
        cell.delegate = self
    }
    
    func checkboxUnchecked(cell: SimpleSelectableCell) {
        cellsDict[cell.tag] = nil
    }
    
    func checkboxChecked(cell: SimpleSelectableCell) {
        if nextActionButton.hidden == true {
            nextActionButton.setTitle("Done adding sharing details", forState: UIControlState.Normal)
            nextActionButton.hidden = false
        }
        cellsDict[cell.tag] = cell
    }
    
    func getUnitAmount() -> Float{
        var segment:Int = sharingTypeSegmentedControl.selectedSegmentIndex
        switch segment{
            case 1:
                for (k, v) in cellsDict{
                    cumulativeWeight += (v as WeightedInputSelectableCell).weight!
                }
            default:
                for (k, v) in cellsDict{
                    cumulativeWeight += 1
                }
        }
        return expense.amount!/Float(cumulativeWeight)
    }
    
    @IBAction func nxtActionClicked(sender: UIButton) {
        if sharingTypeSegmentedControl.selectedSegmentIndex == 0{
            var unitAmount:Float = getUnitAmount()
            for (tag, cell) in cellsDict{
                sharersDict[all[Int(tag)]] = unitAmount
            }
        }
        if sharingTypeSegmentedControl.selectedSegmentIndex == 1{
            var unitAmount:Float = getUnitAmount()
            for (tag, cell) in cellsDict{
                var weightedcell:WeightedInputSelectableCell = cell as WeightedInputSelectableCell
                sharersDict[all[Int(tag)]] = Float(weightedcell.weight!)*unitAmount
            }
        }
        if sharingTypeSegmentedControl.selectedSegmentIndex == 2{
            for (tag, cell) in cellsDict{
                sharersDict[all[Int(tag)]] = ((cell as CustomInputSelectableCell).textField.text as NSString).floatValue
            }
        }
        expense.sharers = sharersDict
        reset()
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
