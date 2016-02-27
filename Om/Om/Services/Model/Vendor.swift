//
//  Vendor.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

class Vendor {
    var id: String
    var location: String
    var image: String
    var address: String
    var mobile: String
    var country_code: String
    var email: String
    var last_name: String
    var first_name: String

    init(dataDict: NSDictionary) {
        id = dataDict["id"] as! String
        location = dataDict["id"] as! String
        image = dataDict["id"] as! String
        address = dataDict["id"] as! String
        mobile = dataDict["id"] as! String
        country_code = dataDict["id"] as! String
        email = dataDict["id"] as! String
        last_name = dataDict["id"] as! String
        first_name = dataDict["id"] as! String
    }
}