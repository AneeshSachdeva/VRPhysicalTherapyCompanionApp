//
//  PatientTherapySession.swift
//  VRPhysicalTherapyPatient
//
//  Created by Aneesh Sachdeva on 1/17/15.
//  Copyright (c) 2015 Applos. All rights reserved.
//

import Foundation

class PatientTherapySession
{
    let startDate : NSDate
    let endDate : NSDate
    
    init(startDate: NSDate, endDate: NSDate)
    {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    func sessionDuration() -> NSTimeInterval
    {
        return abs(self.endDate.timeIntervalSinceDate(self.endDate))
    }
}