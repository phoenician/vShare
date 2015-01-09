//
//  SummaryViewController.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 11/30/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {

    @IBOutlet weak var summaryTable: UITableView!
    var summaries:[Summary] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = selectedEvent?.id {
            
            ds.getSummaries(id, callback: {
                summArray in
                self.summaries = summArray
                dispatch_async(dispatch_get_main_queue()) {
                    self.summaryTable.reloadData()
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return summaries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default
            , reuseIdentifier: "cell")
        var summary = summaries[indexPath.row]
        if let participantId = summary.participantId{
            if let participant = ps.getParticipantById(participantId){
                if let name = participant.name{
                    if let amt = summary.balance{
                        if amt == 0 {
                            cell.textLabel?.text = "\(name) owes nothing"
                        }
                        if amt < 0 {
                            cell.textLabel?.text = "\(name) will receive $\(amt*(-1))"
                        }
                        else{
                            cell.textLabel?.text = "\(name) owes $\(amt)"
                        }
                    }
                    
                }
            }
        }
        return cell
    }
    
}
