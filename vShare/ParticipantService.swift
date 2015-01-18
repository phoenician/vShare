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
        var p1:Participant = Participant(id:"54b5df5f19c759460679a182", name: "Gunjan Shukla", code: "001", phone: "4344090480")
        var p2:Participant = Participant(id:"54b5dfc519c759460679a183", name: "Ankita Mittal", code: "001", phone: "4344663735")
        var p3:Participant = Participant(id:"54af916119c759460679a14f", name: "sulabh", code: "001", phone: "4342429097")
        var p4:Participant = Participant(id:"54b5dfdc19c759460679a184", name: "Rolee Sinha", code: "001", phone: "4342499128")
        
        userdb = [p1, p2, p3, p4]
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
