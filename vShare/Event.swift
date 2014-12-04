//
//  Event.swift
//  groupshare1
//
//  Created by Sulabh Shukla on 11/30/14.
//  Copyright (c) 2014 Sulabh Shukla. All rights reserved.
//

import UIKit

class Event: NSObject {
    
    var desc:NSString = ""
    var members:[NSString] = []
    var kharchas:[Kharcha] = []
    
    func getSummary() -> [NSString:Float]{
        var summary:[NSString:Float] = [NSString:Float]()
        for member in members {
            summary[member] = 0.0
        }
        for kharch in kharchas  {
            for member in kharch.members{
                summary[member] = summary[member]?.advancedBy(kharch.amount)
            }
        }

        return summary
    }
   
}
