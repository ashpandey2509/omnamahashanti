//
//  PanditTableViewCell.swift
//  Om
//
//  Created by Vinita on 2/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit

class PanditTableViewCell: UITableViewCell {
    @IBOutlet weak var borderView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.borderView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.borderView.layer.borderWidth = 0.5
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
