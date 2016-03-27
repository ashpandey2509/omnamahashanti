//
//  NotificationManager.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

class NotificationManager {

    let loginChangeNotificationKey = "login_change_key"

    static let sharedInstance = NotificationManager()

    func notifyLoginChange() {
        NSNotificationCenter.defaultCenter().postNotificationName(loginChangeNotificationKey, object: nil)
    }

}