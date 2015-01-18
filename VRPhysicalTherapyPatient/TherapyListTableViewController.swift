//
//  TherapyListTableViewController.swift
//  VRPhysicalTherapyPatient
//
//  Created by Aneesh Sachdeva on 1/18/15.
//  Copyright (c) 2015 Applos. All rights reserved.
//

import Foundation

class TherapyListTableViewController: UITableViewController
{
    var recordedSessions = [PFObject]()
    
    var selectedUsername : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if PFUser.currentUser() != nil
        {
            selectedUsername = PFUser.currentUser()["username"] as NSString
            
            var query = PFQuery(className: "PatientFrisbeeSession")
            query.whereKey("username", equalTo: selectedUsername)
            query.findObjectsInBackgroundWithBlock {
                (objects: [AnyObject]!, error: NSError!) -> Void in
                if error == nil
                {
                    for object in objects
                    {
                        self.recordedSessions.append(object as PFObject)
                    }
                    
                    println(self.recordedSessions.count)
                    
                    // Reload the table. Ensure the following methods are called after we have populated our patients array.
                    self.tableView.reloadData()
                }
                else
                {
                    println(error)
                }
            }
        }
        else
        {
            NSLog("Can't access doctor's patient relations, since doctor user is nil.")
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recordedSessions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        var therapySession : PFObject
        
        therapySession = recordedSessions[indexPath.row]
        
        let startDate : NSDate = therapySession["startDate"] as NSDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .MediumStyle
        //dateFormatter.dateFormat = "yyyy-MM-dd 'at' h:mm a 'on' " // superset of OP's format
        
        cell.textLabel!.text = "Frisbee on " + dateFormatter.stringFromDate(startDate)
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        println("populated cell")
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user : PFObject = (recordedSessions[indexPath.row] as PFObject)
        selectedUsername = user["username"] as? String
        //let urlString =  "http://nikhilkhanna.github.io/?user=" + selectedUsername!
        self.performSegueWithIdentifier("PresentFrisbeeWebView", sender: selectedUsername)
        
        //UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
        
        println("didSelectRow called")
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "PresentFrisbeeWebView")
        {
            var vc : FrisbeeGraphWebViewController = segue.destinationViewController as FrisbeeGraphWebViewController
            vc.urlString =  "http://nikhilkhanna.github.io/?user=" + selectedUsername!
            
            println("prepareForSegue called")
        }
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
}

