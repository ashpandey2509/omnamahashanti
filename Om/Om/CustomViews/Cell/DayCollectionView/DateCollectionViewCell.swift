//
//  DateCollectionViewCell.swift
//  Om
//
//  Created by Vinita on 2/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class DateCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCellUI(index : Int){
        let calendar = NSCalendar.currentCalendar()
        let today = NSDate()
        let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: index + 1,
            toDate: today,
            options: NSCalendarOptions(rawValue: 0))
        let components = calendar.components([.Day , .Month , .Year], fromDate: tomorrow!)
        
        let day = components.day
        self.dayLabel.text = (tomorrow!.dateNameString.uppercaseString as NSString).substringToIndex(3)
        self.monthLabel.text = tomorrow!.month.uppercaseString
        self.dateLabel.text = "\(String(format: "%02d", day))"
    }

}
