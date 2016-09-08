//
//  Location.swift
//  Om
//
//  Created by Vinita on 9/8/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

public class Location{
    var locationName : String?
    
    init(dictionary : NSDictionary){
        self.locationName = dictionary["name"] as? String
    }
}