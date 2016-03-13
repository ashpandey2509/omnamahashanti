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
    var products : [Product]?
    var loggedInUser : UserProfile?
    var newBookingProduct: Product?
    var newBookingTimeSlot : String?

    public func getProducts(callback: ([Product], NSError?) -> Void ) {

        if let _ = products {
            debugPrint("DEBUG: ", "using cached products")
            callback(products!, nil)
        } else {
            APIService.sharedInstance.getProducts({ (products, error) -> Void in
                self.products = products
                callback(products, error)
            })
        }
    }

    public func isLoggedInUser() -> Bool {
        return !(self.loggedInUser == nil)
    }

    public func clearNewBooking() {
        newBookingTimeSlot = nil
        newBookingProduct = nil
    }
}