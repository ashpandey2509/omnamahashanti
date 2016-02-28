//
//  Vendor.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 2/28/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

public class Vendor {
    var id: String?
    var location: String?
    var image: String?
    var address: String?
    var mobile: String?
    var country_code: String?
    var email: String?
    var last_name: String?
    var first_name: String?
    var experience: String?
    var languages: String?

    init(dataDict: NSDictionary) {
        id = dataDict["id"] as? String
        location = dataDict["location"] as? String
        image = dataDict["image"] as? String
        address = dataDict["address"] as? String
        mobile = dataDict["mobile"] as? String
        country_code = dataDict["country_code"] as? String
        email = dataDict["email"] as? String
        last_name = dataDict["last_name"] as? String
        first_name = dataDict["first_name"] as? String
        experience = dataDict["experience"] as? String
        languages = dataDict["languages"] as? String
    }
}