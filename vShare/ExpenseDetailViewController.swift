//
//  ExpenseDetailViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/24/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

class ExpenseDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var descriptionLabel: UILabel!
    var userid = usrDefaults.objectForKey("userid") as NSString
    var involved:[Participant] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionLabel.text = selectedExpense.desc
        // Do any additional setup after loading the view.
        involved.append(ps.getParticipantById(userid)!)
        involved+=selectedExpense.sharers.keys
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return involved.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "cell")
        cell.textLabel?.text = involved[indexPath.row].name
        return cell
    }
}
