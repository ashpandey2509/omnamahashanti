//
//  UserProfile.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/3/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

class UserProfile : NSObject {
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
    var password = ""

    override init() {
        // empt init
    }

    init(dataDict: NSDictionary) {
        id = dataDict["_id"] as? String
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
    
    required init(coder aDecoder: NSCoder){
        self.id = aDecoder.decodeObjectForKey("id") as? String
        self.email = aDecoder.decodeObjectForKey("email") as? String
        self.mobile = aDecoder.decodeObjectForKey("mobile") as? String
        self.country_code = aDecoder.decodeObjectForKey("country_code") as? String
        self.first_name = aDecoder.decodeObjectForKey("first_name") as? String
        self.last_name = aDecoder.decodeObjectForKey("last_name") as? String
        self.address = aDecoder.decodeObjectForKey("address") as? String
        self.caste = aDecoder.decodeObjectForKey("caste") as? String
        self.sub_caste = aDecoder.decodeObjectForKey("sub_caste") as? String
        self.preferred_language = aDecoder.decodeObjectForKey("preferred_language") as? String
        self.gcm = aDecoder.decodeObjectForKey("gcm") as? String
    }
    
    func encodeWithCoder(encoder: NSCoder)
    {
        if let id = self.id
        {
            encoder.encodeObject(id, forKey: "id")
        }
        
        if let email = self.email
        {
            encoder.encodeObject(email, forKey: "email")
        }
        
        if let mobile = self.mobile
        {
            encoder.encodeObject(mobile, forKey: "mobile")
        }

        if let country_code = self.country_code
        {
            encoder.encodeObject(country_code, forKey: "country_code")
        }
    
        if let first_name = self.first_name
        {
            encoder.encodeObject(first_name, forKey: "first_name")
        }

        if let last_name = self.last_name
        {
            encoder.encodeObject(last_name, forKey: "last_name")
        }

        if let address = self.address
        {
            encoder.encodeObject(address, forKey: "address")
        }
    
        if let caste = self.caste
        {
            encoder.encodeObject(caste, forKey: "caste")
        }

        if let sub_caste = self.sub_caste
        {
            encoder.encodeObject(sub_caste, forKey: "sub_caste")
        }

        if let preferred_language = self.preferred_language
        {
            encoder.encodeObject(preferred_language, forKey: "preferred_language")
        }

        if let gcm = self.gcm
        {
            encoder.encodeObject(gcm, forKey: "gcm")
        }
    }
}