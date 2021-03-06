//
//  DateUtil.swift
//  Om
//
//  Created by Vinita on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

extension NSDate {
    var month: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMM"
        return dateFormatter.stringFromDate(self)
    }
    
    var getBoookingMonth: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter.stringFromDate(self)
    }
    
    
    var dateString: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.stringFromDate(self)
    }
    
    var hour0x: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "hh"
        return dateFormatter.stringFromDate(self)
    }
    var dateNameString: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.stringFromDate(self)
    }
    var dateMilliSecs: Int64 {
        return Int64(self.timeIntervalSince1970*1000)
    }
    
    class func dateFromMilliseconds(ms: NSNumber) -> NSDate {
        return NSDate(timeIntervalSince1970:Double(ms) / 1000.0)
    }
    
    
    
}
