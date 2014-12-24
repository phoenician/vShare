//
//  SummaryViewController.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 11/30/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var heading: UILabel!
    var summary:[NSString:Float] = [NSString:Float]()
    override func viewDidLoad() {
        super.viewDidLoad()
        heading.text = "Summary for event \(selectedEvent?.desc)"
        if let summ = selectedEvent?.getSummary(){
            summary = summ
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let mems = selectedEvent?.members{
            return mems.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "cell")
        //var key = event.members[indexPath.row]
        //var amt = summary[key]
        //cell.textLabel.text = "\(key) owes $\(amt!)"
        return cell
    }
    
}
