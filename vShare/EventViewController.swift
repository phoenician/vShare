//
//  EventViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/23/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var selectedExpense:Kharcha = Kharcha()

class EventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var expenses:[Kharcha] = []
    
    @IBOutlet weak var expenseTable: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "Expenses for \(selectedEvent)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = selectedEvent?.id {
            
            ds.getExpenses(id, callback: {
                expArray in
                for exp in expArray {
                    self.expenses.append(exp)
                }
                dispatch_async(dispatch_get_main_queue()) {
                    self.expenseTable.reloadData()
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return expenses.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "eventcell")
        cell.textLabel.text = expenses[indexPath.row].desc
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedExpense = expenses[indexPath.row]
        self.performSegueWithIdentifier("showExpenseDetails", sender: indexPath)
    }

}
