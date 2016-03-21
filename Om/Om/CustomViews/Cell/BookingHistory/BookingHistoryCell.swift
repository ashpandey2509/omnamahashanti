//
//  BookingHistoryCell.swift
//  Om
//
//  Created by Vinita on 3/14/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class BookingHistoryCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var panditLabel: UILabel!
    @IBOutlet weak var poojaLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
