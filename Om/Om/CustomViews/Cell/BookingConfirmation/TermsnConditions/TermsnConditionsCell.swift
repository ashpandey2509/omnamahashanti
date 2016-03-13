//
//  TermsnConditionsCell.swift
//  Om
//
//  Created by Vinita on 3/13/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class TermsnConditionsCell: UITableViewCell {
    @IBOutlet weak var termsLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        let completeText = "I agree to Terms and Conditions"
        let highlightText = "Terms and Conditions"
        let range = (completeText as NSString).rangeOfString(highlightText)
        let attributedString = NSMutableAttributedString(string:completeText)
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.getThemeColor() , range: range)
        self.termsLabel.attributedText = attributedString
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
