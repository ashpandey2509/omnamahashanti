//
//  UserProfile.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/3/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

class UserProfile {
    var id: String?
    var email: String?
    var mobile: String?
    var country_code: String?
    var first_name: String?
    var last_name: String?
    var address: String?
    var caste: String?
    var sub_caste: String?
    var preferred_language: String?
    var gcm: String?


    init(dataDict: NSDictionary) {
        id = dataDict["id"] as? String
        email = dataDict["email"] as? String
        mobile = dataDict["mobile"] as? String
        country_code = dataDict["country_code"] as? String
        first_name = dataDict["first_name"] as? String
        last_name = dataDict["last_name"] as? String
        address = dataDict["address"] as? String
        caste = dataDict["caste"] as? String
        sub_caste = dataDict["sub_caste"] as? String
        preferred_language = dataDict["preferred_language"] as? String
        gcm = dataDict["gcm"] as? String
    }
}