//
//  DataService.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/10/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

class DataService: NSObject {
    
    func getParticipant(countryCode:NSString, phone:NSString) -> NSString? {
        var id:NSString = ""
        let urlPath = "http://localhost:3000/api/user/\(countryCode)/\(phone)"
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
        if error != nil {
            println(error)
        } else {
            var err: NSError?
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            if let user = jsonResult[0] as? NSDictionary{
                if let userid = user["_id"] as? NSString{
                    println("USER ID is \(userid)")
                    id = userid
                }
            }
        }
        })
        task.resume()
        return id
    }
    
    func getEvents(userid:NSString, callback:([Event]) -> ()){
        var events:[Event] = []
        let urlPath = "http://localhost:3000/api/event/\(userid)"
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            if error != nil {
                println(error)
            } else {
                var err: NSError?
                var jsonArr = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
                if (err != nil) {
                    println("JSON Error \(err!.localizedDescription)")
                }
                for i in 0..<jsonArr.count {
                    if let eventName = jsonArr[i]["name"] as? NSString{
                        if let eventId = jsonArr[i]["_id"] as? NSString{
                            
                            var event:Event = Event()
                            event.id = eventId
                            event.desc = eventName
                            
                            if let participantIds:[NSString] = jsonArr[i]["participants"] as? [NSString] {
                                var shallowParticipants:[Participant] = []
                                for id in participantIds{
                                    shallowParticipants.append(Participant(id: id))
                                }
                                event.members = shallowParticipants
                            }
                            events.append(event)
                        }
                    }
                }
                callback(events)
            }
        })
        task.resume()
    }
    
    func getExpenses(eventid:NSString, callback:([Kharcha]) -> ()){
        var kharchas:[Kharcha] = []
        let urlPath = "http://localhost:3000/api/expense/\(eventid)"
        let url = NSURL(string: urlPath)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            if error != nil {
                println(error)
            } else {
                var err: NSError?
                var jsonArr = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSArray
                if (err != nil) {
                    println("JSON Error \(err!.localizedDescription)")
                }
                for i in 0..<jsonArr.count {
                    var kharcha:Kharcha = Kharcha()
                    if let desc = jsonArr[i]["description"] as? NSString{
                        kharcha.desc = desc
                    }
                    if let id = jsonArr[i]["_id"] as? NSString{
                        kharcha.id = id
                    }
                    if let eventid = jsonArr[i]["eventid"] as? NSString{
                        kharcha.eventId = eventid
                    }
                    if let participantIds:[NSString] = jsonArr[i]["participants"] as? [NSString] {
                        var participants:[Participant] = []
                        for id in participantIds{
                            participants.append(Participant(id: id))
                        }
                        kharcha.participants = participants
                    }
                    if let creator = jsonArr[i]["creator"] as? NSString{
                        kharcha.creator = creator
                    }
                    if let created = jsonArr[i]["created"] as? NSString{
                        kharcha.created = created
                    }
                    kharchas.append(kharcha)
                }
                callback(kharchas)
            }
        })
        task.resume()
    }
    
    func saveExpense(exp:Kharcha, callback: (NSString) -> Void) {
        let req = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/api/expense/add")!)
        req.HTTPMethod = "POST"
        req.HTTPBody = exp.getExpenseJSONData()
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postTask = NSURLSession.sharedSession().dataTaskWithRequest(req){
            data, response, error in
            var err: NSError?
            var jsonRes = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            if let expenseId = jsonRes["expenseid"] as? NSString{
                callback(expenseId)
            }
        }
        postTask.resume()
    }
    
    func saveUser(name:NSString, code:NSString, phone:NSString, callback: (NSString) -> Void) {
        let req = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/api/user/add")!)
        req.HTTPMethod = "POST"
        let postString = "{\"name\":\"\(name)\", \"phone\":\"\(phone)\", \"countrycode\":\"\(code)\"}"
        req.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postTask = NSURLSession.sharedSession().dataTaskWithRequest(req){
            data, response, error in
            var err: NSError?
            var jsonRes = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            if let userid = jsonRes["userid"] as? NSString{
                callback(userid)
            }
        }
        postTask.resume()
    }
    
    func saveEvent(evnt:Event, callback: (NSString) -> Void) {
        let req = NSMutableURLRequest(URL: NSURL(string: "http://localhost:3000/api/event/add")!)
        req.HTTPMethod = "POST"
        /*var date = NSDate()
        let postString = "{\"name\":\"\(evnt.desc)\", \"created\":\"\(date)\", \"participants\":\"\(evnt.getParticipantIdsArray())\"}"
        
        println("-------- JSON String for post event is: \(postString) -------------")
        
        req.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)*/
        req.HTTPBody = evnt.getEventJSONData()
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let postTask = NSURLSession.sharedSession().dataTaskWithRequest(req){
            data, response, error in
            var err: NSError?
            var jsonRes = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if (err != nil) {
                println("JSON Error \(err!.localizedDescription)")
            }
            if let eventId = jsonRes["eventid"] as? NSString{
                callback(eventId)
            }
        }
        postTask.resume()
    }
}
