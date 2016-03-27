//
//   NotificationManager.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

class NotificationManager {

    static let sharedInstance = NotificationManager()

    let loginChangeNotificationKey = "notification_login_change"

    func notifyLoginChange() {
        NSNotificationCenter.defaultCenter().postNotificationName(loginChangeNotificationKey, object: nil)
    }
}