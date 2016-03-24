//
//  BookingConfirmationEntry.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/21/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

public class BookingConfirmationEntry {
    let title : String?
    let value : String?

    init(title : String, value : String) {
        self.title = title
        self.value = value
    }
}