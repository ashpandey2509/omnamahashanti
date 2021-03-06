//
//  ColorUtil.swift
//  Om
//
//  Created by Vinita on 2/26/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation
import UIKit
extension UIColor{
    
    convenience init(hexString: String) {
        let hex = hexString.stringByTrimmingCharactersInSet(NSCharacterSet.alphanumericCharacterSet().invertedSet)
        var int = UInt32()
        NSScanner(string: hex).scanHexInt(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }

    class func getOrderConfirmationTitleColor() -> UIColor{
        return UIColor(hexString: "#777777")
    }
    
    class func getThemeColor() -> UIColor{
        return UIColor(hexString: "#ffe9433a")
    }

    class func getBookPoojaBorderColor() -> UIColor{
        return UIColor(hexString: "#ffcccccc")
    }
    
    class func getTimeSlotBackgroundColor() -> UIColor{
        return UIColor(hexString: "#fff19368")
    }
    
    class func getSamagriColor() -> UIColor{
        return UIColor(hexString: "#777777")
    }
    
    class func getDateNormalColor() -> UIColor{
        return UIColor(hexString: "#7F7F7F")
    }
    
    class func getCalendarMonthDayNormalColor() -> UIColor{
        return UIColor(hexString: "#7F7F7F")
    }
    
    class func getCalendarDateNormalColor() -> UIColor{
        return UIColor(hexString: "#000000")
    }
    
    class func getCalendarMonthDaySelectedColor() -> UIColor{
        return UIColor(hexString: "#000000")
    }
    
    class func getCalendarDateSelectedlColor() -> UIColor{
        return UIColor(hexString: "#000000")
    }
}