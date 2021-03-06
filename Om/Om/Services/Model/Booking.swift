//
//  Booking.swift
//  Om
//
//  Created by Vinita on 3/14/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

class Booking{
    var locationDetails : Location?
    var product : Product?
    var vendor : Vendor?
    var _id : String?
    var user_id : String?
    var slot : String?
    var location : String?
    var book_date : String?
    var book_date_NSDate : NSDate?
    var address : String?
    var __v : Int?
    var active : Bool?
    var updated_date : String?
    var created_date : String?
    var status : String?
    var book_date_display : String?
    var dateString : String?
    var dayString : String?
    init() {
        // empty constructor
    }
    
    init(dataDict: NSDictionary) {
        _id = dataDict["_id"] as? String
        user_id = dataDict["user_id"] as? String
        slot = dataDict["slot"] as? String
        location = dataDict["location"] as? String
        
        if let bookDate = dataDict["book_date"] as? Double{
            let miliDate = NSDate.dateFromMilliseconds(bookDate)
            self.dateString = miliDate.getBoookingMonth

            self.dayString = miliDate.dateNameString

            book_date = "\(bookDate)"
        }
        
        
        
        address = dataDict["address"] as? String
        __v = dataDict["__v"] as? Int
        active = dataDict["active"] as? Bool
        updated_date = dataDict["updated_date"] as? String
        created_date = dataDict["created_date"] as? String
        status = dataDict["status"] as? String
        book_date_display = dataDict["book_date_display"] as? String
        
        if let vendor = dataDict["vendor_id"] as? NSDictionary{
            self.vendor = Vendor(dataDict: vendor)
        }

        if let product = dataDict["product_id"] as? NSDictionary{
            self.product = Product(dataDict: product)
        }
    }

    
    func getDisplayDate() -> String {
        let dateFormatter = NSDateFormatter()
        let date = dateFormatter.dateFromString(self.updated_date!)
        dateFormatter.dateFormat = "dd MMM"
        let dateString = dateFormatter.stringFromDate(date!)
        return dateString
    }
}

