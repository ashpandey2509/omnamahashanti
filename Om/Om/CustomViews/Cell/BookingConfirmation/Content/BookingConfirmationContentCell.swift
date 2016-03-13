//
//  BookingConfirmationContentCell.swift
//  Om
//
//  Created by Vinita on 3/13/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class BookingConfirmationContentCell: UITableViewCell {
    @IBOutlet weak var titleMutiplier: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
