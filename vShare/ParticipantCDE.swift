//
//  ParticipantCDE.swift
//  vShare
//
//  Created by Rolee Sinha on 2/4/15.
//  Copyright (c) 2015 eva. All rights reserved.
//

import Foundation
import CoreData

class ParticipantCDE: NSManagedObject {

    @NSManaged var countrycode: String
    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var phone: String
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    convenience init(p:Participant, context: NSManagedObjectContext?){
        var entity:NSEntityDescription = NSEntityDescription.entityForName("ParticipantCDE", inManagedObjectContext: context!)!
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        //init(insertIntoManagedObjectContext:context)
        self.id = p.id!
        self.name = p.name!
        self.phone = p.phone!
        self.countrycode = p.countrycode!
    }
    
    func getParticipant() -> Participant{
        return Participant(id: self.id, name: self.name, code: self.countrycode, phone: self.phone)
    }

}
