//
//  DataService.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/10/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit

class DataService: NSObject {
    
    var jserver_url = "http://jserver-vshare.rhcloud.com"
    //var jserver_url = "http://localhost:8080"
    
    func getParticipant(countryCode:NSString, phone:NSString) -> NSString? {
        var id:NSString = ""
        let urlPath = "\(jserver_url)/api/user/\(countryCode)/\(phone)"
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
    
    func searchParticipants(attribute:NSString, searchstr:NSString, callback:([Participant]) -> ()){
        var users:[Participant] = []
        let urlPath = "\(jserver_url)/api/usersearch/\(attribute)/\(searchstr)"
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
                    if let name = jsonArr[i]["name"] as? NSString{
                        if let userId = jsonArr[i]["_id"] as? NSString{
                            if let phone = jsonArr[i]["phone"] as? NSString{
                                if let countrycode = jsonArr[i]["countrycode"] as? NSString{
                                    var user:Participant = Participant(id: userId, name: name, code: countrycode, phone: phone)
                                    users.append(user)
                                }
                            }
                        }
                    }
                }
                callback(users)
            }
        })
        task.resume()
    }
    
    func getEvents(userid:NSString, callback:([Event]) -> ()){
        var events:[Event] = []
        let urlPath = "\(jserver_url)/api/event/\(userid)"
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
        let urlPath = "\(jserver_url)/api/expense/\(eventid)"
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
                for json in jsonArr {
                    kharchas.append(Kharcha(json: json))
                }
                callback(kharchas)
            }
        })
        task.resume()
    }
    
    func getSummaries(eventid:NSString, callback:([Summary]) -> ()){
        var summaries:[Summary] = []
        let urlPath = "\(jserver_url)/api/summary/\(eventid)"
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
                    var summary:Summary = Summary()
                    if let id = jsonArr[i]["_id"] as? NSString{
                        summary.id = id
                    }
                    if let eventid = jsonArr[i]["event"] as? NSString{
                        summary.eventId = eventid
                    }
                    if let participantid = jsonArr[i]["participant"] as? NSString{
                        summary.participantId = participantid
                    }
                    if let updated = jsonArr[i]["updated"] as? NSString{
                        summary.updated = updated
                    }
                    if let balance = jsonArr[i]["balance"] as? Float{
                        summary.balance = balance
                    }
                    summaries.append(summary)
                }
                callback(summaries)
            }
        })
        task.resume()
    }
    
    func saveExpense(exp:Kharcha, callback: (NSString) -> Void) {
        let req = NSMutableURLRequest(URL: NSURL(string: "\(jserver_url)/api/expense/add")!)
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
        let req = NSMutableURLRequest(URL: NSURL(string: "\(jserver_url)/api/user/add")!)
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
        let req = NSMutableURLRequest(URL: NSURL(string: "\(jserver_url)/api/event/add")!)
        req.HTTPMethod = "POST"
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
