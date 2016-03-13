//
//  FontUtil.swift
//  Om
//
//  Created by Vinita on 2/26/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation

extension UIFont {
    convenience init(dictionary : NSDictionary) {
        self.init(name : dictionary["name"]! as! String, size : dictionary["size"]! as! CGFloat)!
    }
    
    func widthOfString (string: String, constrainedToHeight height: Double) -> CGSize {
        return (string as NSString).boundingRectWithSize(CGSize(width: DBL_MAX, height: height),
            options: NSStringDrawingOptions.UsesLineFragmentOrigin,
            attributes: [NSFontAttributeName: self],
            context: nil).size
    }
    
    func heightOfString(string: String, constrainedToWidth width: Double) -> CGSize {
        let attrString = NSAttributedString.init(string: string, attributes: [NSFontAttributeName:self])
        let rect = attrString.boundingRectWithSize(CGSize(width: width, height: 999), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil)
        let size = CGSizeMake(rect.size.width, rect.size.height)
        return size
    }
    

}