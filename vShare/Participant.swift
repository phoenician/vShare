//
//  Participant.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/12/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

var ps:ParticipantService = ParticipantService()

class Participant: NSObject, Equatable {
    var id:NSString?
    var name:NSString?
    var countrycode:NSString?
    var phone:NSString?
    
    init(id:NSString){
        self.id = id
        if let p = ps.getParticipantById(id){
            self.name = p.name
            self.countrycode = p.countrycode
            self.phone = p.phone
        }
    }
    
    init(name:NSString, code:NSString, phone:NSString) {
        self.name = name
        self.phone = phone
        self.countrycode = code
        self.id = NSUUID().UUIDString
    }
    
    init(id:NSString, name:NSString, code:NSString, phone:NSString) {
        self.name = name
        self.phone = phone
        self.countrycode = code
        self.id = id
    }
}

func ==(lhs: Participant, rhs: Participant) -> Bool {
    if lhs.id == rhs.id {
        return true
    }
    return false
}
