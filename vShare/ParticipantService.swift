//
//  ParticipantService.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/12/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit
import CoreData


class ParticipantService: NSObject {
    
    func saveParticipantToCoreData(participant:Participant){
        //save if not already in core data
        if getParticipantById(participant.id!) == nil {
            let user = NSEntityDescription.insertNewObjectForEntityForName("ParticipantCDE", inManagedObjectContext: getManagedContext()) as ParticipantCDE
            var context:NSManagedObjectContext = getManagedContext()
            var pcde:ParticipantCDE = ParticipantCDE(p: participant, context: context)
            var savingError: NSError?
            if context.save(&savingError){
                println("Successfully saved logged in user \(participant.name!)")
            } else {
                if let error = savingError{
                    println("Failed to save the user. Error = \(error)")
                }
            }
        }
    }
    
    func getPrincipal() -> Participant?{
        var requestError: NSError?
        let managedObjectContext:NSManagedObjectContext = getManagedContext()
        let fetchReq = getFetchRequest()
        let idPredicate = NSPredicate(format: "id == %@", usrDefaults.objectForKey("userid") as String)
        fetchReq.predicate = idPredicate
        let principal = getManagedContext().executeFetchRequest(fetchReq,
            error: &requestError) as [ParticipantCDE]
        if principal.count == 1{
            return principal[0].getParticipant()
        } else {
            println("Could not find any Principal entity in the context")
            return nil
        }
    }
    
    
    func getAllParticipantsFromCoreData() -> [Participant]
    {
        var p:[Participant] = []
        var requestError: NSError?
        
        let managedObjectContext:NSManagedObjectContext = getManagedContext()
        let fetchReq = getFetchRequest()
        let idNotNilPredicate = NSPredicate(format: "id != nil")
        fetchReq.predicate = idNotNilPredicate
        if let result = managedObjectContext.executeFetchRequest(fetchReq, error: &requestError) as? [ParticipantCDE]{
            if (requestError != nil){
                println("Error in getAllParticipantsFromCoreData(): \(requestError?.localizedDescription)")
                return []
            }
            for r:ParticipantCDE in result{
                p.append(r.getParticipant())
            }
        }
        return p
    }
    
    
    func getParticipantsFromCoreDataMatchName(name:NSString) -> [Participant]
    {
        var ps:[Participant] = []
        var requestError: NSError?
        let fetchReq = getFetchRequest()
        let namePredicate = NSPredicate(format: "name == %@", name)
        fetchReq.predicate = namePredicate
        if let result = getManagedContext().executeFetchRequest(fetchReq, error: &requestError) as? [ParticipantCDE]{
            if (requestError != nil){
                println("Error in getParticipantsFromCoreDataMatchName(): \(requestError?.localizedDescription)")
            }else{
                for r in result{
                    ps.append(r.getParticipant())
                }
                return ps
            }
        }
        return []
    }
    
    
    func getParticipantsFromCoreDataMatchPhone(phone:NSString) -> [Participant]
    {
        var ps:[Participant] = []
        var requestError: NSError?
        let fetchReq = getFetchRequest()
        let namePredicate = NSPredicate(format: "phone == %@", phone)
        fetchReq.predicate = namePredicate
        if let result = getManagedContext().executeFetchRequest(fetchReq, error: &requestError) as? [ParticipantCDE]{
            if (requestError != nil){
                println("Error in getParticipantsFromCoreDataMatchPhone(): \(requestError?.localizedDescription)")
                return []
            }else{
                for r in result{
                    ps.append(r.getParticipant())
                }
                return ps
            }
        }
        return []
    }
    
    func getParticipantById(id:NSString) -> Participant?{
        var requestError: NSError?
        let fetchReq = getFetchRequest()
        let namePredicate = NSPredicate(format: "id == %@", id)
        fetchReq.predicate = namePredicate
        if let result = getManagedContext().executeFetchRequest(fetchReq, error: &requestError) as? [ParticipantCDE]{
            if (requestError != nil){
                println("Error in getParticipantById(): \(requestError?.localizedDescription)")
                return nil
            }
            else{
                if (result.count > 0){
                    return result[0].getParticipant()
                }
                return nil
            }
        }
        return nil
    }
    
    func getManagedContext() -> NSManagedObjectContext
    {
        let fetchRequest = NSFetchRequest(entityName: "ParticipantCDE")
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        return managedContext
    }
    
    func getFetchRequest() -> NSFetchRequest
    {
        let fetchReq = NSFetchRequest(entityName: "ParticipantCDE")
        let sortDescriptor1 = NSSortDescriptor(key: "name", ascending: true)
        let sortDescriptor2 = NSSortDescriptor(key: "phone", ascending: true)
        let sortDescriptor3 = NSSortDescriptor(key: "countrycode", ascending: true)
        fetchReq.sortDescriptors = [sortDescriptor1, sortDescriptor2, sortDescriptor3]
        return fetchReq
    }
}
