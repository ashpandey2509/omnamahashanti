//
//  Product.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 2/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

public class Product {
    var id: String
    var cost: Int
    var detail: String
    var name: String
    var morning: Bool
    var afternoon: Bool
    var evening: Bool
    
    init(dataDict: NSDictionary) {
        id = dataDict["id"] as! String
        cost = dataDict["cost"] as! Int
        detail = dataDict["detail"] as! String
        name = dataDict["name"] as! String
        morning = dataDict["morning"] as! Bool
        afternoon = dataDict["afternoon"] as! Bool
        evening = dataDict["evening"] as! Bool
    }
}