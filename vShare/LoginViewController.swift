//
//  LoginViewController.swift
//  vShare
//
//  Created by Sulabh Shukla on 12/9/14.
//  Copyright (c) 2014 eva. All rights reserved.
//

import UIKit


var usrDefaults:NSUserDefaults = NSUserDefaults.standardUserDefaults()
var ds:DataService = DataService()

class LoginViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var tellUsLabel: UILabel!

    @IBAction func doneButtonClicked(sender: AnyObject) {
        //call asynch function that saves and calls another async function that segues
        
        if !(nameField.text.isEmpty || countryField.text.isEmpty || phoneField.text.isEmpty){
            var name = nameField.text
            var phone = phoneField.text
            var code = countryField.text
            usrDefaults.setObject(name, forKey: "name")
            usrDefaults.setObject(code, forKey: "countrycode")
            usrDefaults.setObject(phone, forKey: "phone")
            asyncSave(name, phone: phone, code: code, callback: {
                dispatch_async(dispatch_get_main_queue()) {
                    self.performSegueWithIdentifier("showEventsViewSegue", sender: self)
                    ps.userdb.append(Participant(id:usrDefaults.objectForKey("userid") as NSString, name: name, code: code, phone: phone))
                }
            })
        }else{
            tellUsLabel.text = "Please fill out all text fields ..."
        }
    }
    
    func asyncSave(name:NSString, phone:NSString, code:NSString, callback:()-> Void){
        ds.saveUser(name, code: code, phone: phone){
            userid in
            usrDefaults.setObject(userid, forKey: "userid")
            callback()
        }
    }
    
    func segueToEventsView(){
        self.performSegueWithIdentifier("showEventsViewSegue", sender: self)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        nameField.resignFirstResponder()
        countryField.resignFirstResponder()
        phoneField.resignFirstResponder()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isUserAlreadyLoggedIn(){
            self.performSegueWithIdentifier("showEventsViewSegue", sender: self)
        }
    }
    
    func isUserAlreadyLoggedIn() -> Bool {
        if let id = usrDefaults.objectForKey("userid") as? String{
            if id != "" {
                return true
            }//id is neither null nor empty string
            return false
        }
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
