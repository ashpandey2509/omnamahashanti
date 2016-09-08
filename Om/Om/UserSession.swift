//
//  UserSession.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

public class UserSession {

    static let sharedInstance = UserSession()
    var newBooking : Booking?

    init() {
        newBooking = Booking()
        newBooking?.user_id = self.getUserData()?.id
    }

    
    public func getProducts(callback: ([Product], [Location], NSError?) -> Void ) {
        APIService.sharedInstance.getProducts({ (products,locations, error) -> Void in
            callback(products,locations, error)
        })
    }

    public func isLoggedInUser() -> Bool {
        return !(self.getUserData() == nil)
    }

    func saveUserData(userprofile : UserProfile?){
        if let userProfile = userprofile{
            let userDefault = NSUserDefaults.standardUserDefaults()
            let customerData = NSKeyedArchiver.archivedDataWithRootObject(userProfile)
            userDefault.setObject(customerData, forKey: "ProfileData")
            userDefault.synchronize()
        }
        else{
            let userDefault = NSUserDefaults.standardUserDefaults()
            userDefault.removeObjectForKey("ProfileData")
            userDefault.synchronize()
        }
    }
    
    func getUserData() -> UserProfile?{
        let customerDetail : NSData? = NSUserDefaults.standardUserDefaults().objectForKey("ProfileData") as? NSData
        if let details = customerDetail {
            let customer = NSKeyedUnarchiver.unarchiveObjectWithData(details) as? UserProfile
            return customer
        }
        return nil
    }
    
    
}