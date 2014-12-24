//
//  ParticipantService.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/12/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

class ParticipantService: NSObject {
    
    var userdb:[Participant] = []
    
    override init() {
        var p1:Participant = Participant(id:"5490bf496ee729f2944973d1", name: "Rolee Shukla", code: "001", phone: "4342499128")
        var p2:Participant = Participant(id:"5495ee3208a489dfdf4d6213", name: "Sulabh Shukla", code: "001", phone: "4342429097")
        var p3:Participant = Participant(id:"5490bf826ee729f2944973d3", name: "Ramesh Chandra Shukla", code: "91", phone: "4342429097")
        
        userdb = [p1, p2, p3]
    }
    
    func getMatchingParticipants(p:Participant) -> [Participant]
    {
        
        let p1 = userdb.filter{
            if let name:NSString = $0.name {
                if let enteredname = p.name {
                    return name.lowercaseString.rangeOfString(enteredname.lowercaseString) != nil
                }
                else{
                    return false
                }
            }
            else {
                return false
            }
        }
        return p1

    }
    
    func getParticipantById(id:NSString) -> Participant?{
        for p in userdb {
            if p.id == id {
                return p
            }
        }
        return nil
    }
}
