//
//  Kharcha.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 11/29/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit

class Kharcha: NSObject {
    var id:NSString?
    var desc:NSString?
    var amount:Float?
    var eventId:NSString?
    var spenderId:NSString?
    var creator:NSString?
    var created:NSString?
    var participants:[Participant] = []
    
    func getExpenseJSONData() -> NSData {
        var data = getExpenseAsDict()
        var err: NSError?
        var json = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted, error: &err)
        return json!
    }
    
    func getExpenseAsDict() -> NSDictionary {
        var dict:NSDictionary = ["description":self.desc!, "amount": self.amount!, "event":self.eventId!, "spender":self.spenderId!, "creator":self.creator!, "created":"2014-12-20", "participants":getParticipantIdsArray()]
        return dict
    }
    
    func getParticipantIdsArray() -> [NSString]{
        var memberIds:[NSString] = []
        for m in participants {
            memberIds.append(m.id!)
        }
        return memberIds
    }
    
}
