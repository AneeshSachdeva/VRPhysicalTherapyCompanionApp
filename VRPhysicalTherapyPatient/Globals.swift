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
//        var parseTherapyRecords = PFObject(className: "TotalSessions")
//        parseTherapyRecords["patient"] = PFUser.currentUser().username
//        parseTherapyRecords["sessionIDs"] = THERAPY_SESSIONS
//        
//        parseTherapyRecords.saveInBackground()
        var currentParseSessions = PFUser.currentUser()
        PFUser.currentUser()["sessionIDs"] = THERAPY_SESSIONS
    }
}