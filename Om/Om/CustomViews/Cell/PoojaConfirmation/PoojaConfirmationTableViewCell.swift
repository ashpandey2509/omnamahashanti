//
//  CurrentBookingCell.swift
//  Om
//
//  Created by Vinita on 3/6/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class CurrentBookingCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var panditNameLabel: UILabel!
    @IBOutlet weak var poojaType: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
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
