//
//  Event.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 11/30/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit

class Event: NSObject {
    var id:NSString?
    var desc:NSString?
    var members:[Participant] = []
    var kharchas:[Kharcha] = []
        
    func getParticipantIdsArray() -> [NSString]{
        var memberIds:[NSString] = []
        for m in members {
            memberIds.append(m.id!)
        }
        return memberIds
    }
    
    func getEventJSONData() -> NSData {
        var data = getEventAsDict()
        var err: NSError?
        var json = NSJSONSerialization.dataWithJSONObject(data, options: NSJSONWritingOptions.PrettyPrinted, error: &err)
        return json!
    }
    
    func getEventAsDict() -> NSDictionary {
        let description = self.desc
        var dict:NSDictionary = ["name":description!, "created":"2014-12-20", "participants":getParticipantIdsArray()]
        return dict
    }
    
    func getSummary() -> [NSString:Float]{
        var summary:[NSString:Float] = [NSString:Float]()
        return summary
    }
    
}
