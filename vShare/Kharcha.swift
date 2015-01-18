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
    var sharers:[Participant:Float] = [:]
    var spenders:[Participant:Float] = [:]
    
    override init() {
        super.init()
    }
    
    init(json:AnyObject) {
        if let desc = json["description"] as? NSString{
            self.desc = desc
        }
        if let id = json["_id"] as? NSString{
            self.id = id
        }
        if let eventid = json["event"] as? NSString{
            self.eventId = eventid
        }
        if let amount = json["amount"] as? Float{
            self.amount = amount
        }
        if let creator = json["creator"] as? NSString{
            self.creator = creator
        }
        if let created = json["created"] as? NSString{
            self.created = created
        }
        
        if let sharers:[NSDictionary] = json["sharers"] as? [NSDictionary] {
            for sharer in sharers {
                self.sharers[Participant(id: (sharer["id"] as? NSString)!)] = (sharer["share"] as NSString).floatValue
            }
        }
        if let spenders:[NSDictionary] = json["spenders"] as? [NSDictionary] {
            for spender in spenders {
                self.spenders[Participant(id: (spender["id"] as? NSString)!)] = (spender["share"] as NSString).floatValue
            }
        }
    }
    
    func getExpenseJSONData() -> NSData {
        var data = getExpenseAsDict()
        var err: NSError?
        var json = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted, error: &err)
        return json!
    }
    
    func getExpenseAsDict() -> NSDictionary {
        var dict:NSDictionary = ["description":self.desc!, "amount": self.amount!, "event":self.eventId!, "creator":self.creator!, "spenders":getSpendersList(), "sharers":getSharersList()]
        return dict
    }
    
    func getSharersList() -> [NSDictionary]{
        var sharersList:[NSDictionary] = []
        for (k, v) in sharers {
            var sharer:NSDictionary = ["id":k.id!, "share":v]
            sharersList.append(sharer)
        }
        return sharersList
    }
    
    func getSpendersList() -> [NSDictionary]{
        var spendersList:[NSDictionary] = []
        for (k, v) in spenders {
            var spender:NSDictionary = ["id":k.id!, "share":v]
            spendersList.append(spender)
        }
        return spendersList
    }
}
