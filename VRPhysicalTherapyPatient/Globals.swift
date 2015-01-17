//
//  Globals.swift
//  VRPhysicalTherapyPatient
//
//  Created by Aneesh Sachdeva on 1/17/15.
//  Copyright (c) 2015 Applos. All rights reserved.
//

import Foundation

struct Globals
{
    static var USER = PFUser()
    
    static var THERAPY_SESSIONS = [String]() // TODO: THIS NEEDS TO BE SAVED
    
    static func saveTherapySessions()
    {
        // Here we append the new sessions to the current sessions, then save all the sessions to parse (new and old).
        if PFUser.currentUser() != nil
        {
            var currentParseSessions : [String] = PFUser.currentUser()["sessionIDs"] as [String]
            
            // Merge arrays.
            for objectId in THERAPY_SESSIONS
            {
                currentParseSessions.append(objectId)
            }
            
            PFUser.currentUser()["sessionIDs"] = currentParseSessions
            //println(THERAPY_SESSIONS.count)
        }
        else
        {
            println("PFUser current user is nil")
        }
    }
}