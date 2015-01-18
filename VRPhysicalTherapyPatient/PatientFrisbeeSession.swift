//
//  PatientFrisbeeSession.swift
//  VRPhysicalTherapyPatient
//
//  Created by Aneesh Sachdeva on 1/17/15.
//  Copyright (c) 2015 Applos. All rights reserved.
//

import Foundation

class PatientFrisbeeSession : PatientTherapySession
{
    let frisbeesSwatted : Int
    let maxFrisbeeSpeed : Float
    
    init(username: String, startDate: NSDate, endDate: NSDate, frisbeesSwatted: Int, maxFrisbeeSpeed: Float)
    {
        self.frisbeesSwatted = frisbeesSwatted
        self.maxFrisbeeSpeed = maxFrisbeeSpeed
        
        super.init(username: username, startDate: startDate, endDate: endDate)
    }
    
    /** Save the Frisbee Session to Parse and globally store the parse object ID. */
    func saveToParse()
    {
        // The parse representation of the session.
        var patientFrisbeeSession = PFObject(className: "PatientFrisbeeSession")
        patientFrisbeeSession["username"] = username
        patientFrisbeeSession["startDate"] = startDate
        patientFrisbeeSession["endDate"] = endDate
        patientFrisbeeSession["frisbeesSwatted"] = frisbeesSwatted
        patientFrisbeeSession["maxFrisbeeSpeed"] = maxFrisbeeSpeed
        
        
        if PFUser.currentUser() != nil
        {
            // Add the read permissions for security.
            //patientFrisbeeSession.ACL = PFACL(user: PFUser.currentUser())
            patientFrisbeeSession.saveInBackgroundWithBlock {
                (success: Bool!, error: NSError!) -> Void in
                if (success != nil) {
                    NSLog("Object created with id: \(patientFrisbeeSession.objectId)")
                
//                    Globals.THERAPY_SESSIONS.append(patientFrisbeeSession.objectId);
//                    println(Globals.THERAPY_SESSIONS.count) 
//                    Globals.saveTherapySessions()
//                    println("Therapy Sessions append and save attempted.")
                    
                } else {
                    NSLog("%@", error)
                }
            }
            
        }
    }
}