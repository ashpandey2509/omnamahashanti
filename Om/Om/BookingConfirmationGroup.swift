//
//  BookingConfirmationGroup.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/21/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

public class BookingConfirmationGroup {

    static let GROUP_TYPE_KEY_VALUE = "key_value"
    static let GROUP_TYPE_STRING_ARRAY = "string_array"

    let header : String
    var entries : [AnyObject]?
    var type : String

    init (header : String, type : String) {
        self.header = header
        self.entries = [AnyObject]()
        self.type = type
    }
}