//
//  ActivityIndicator.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/13/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation
import MMMaterialDesignSpinner

public class ActivityIndicator: MMMaterialDesignSpinner {

    init(parent: UIView) {
        super.init(frame: CGRectMake(0, 0, 40, 40))
        center = parent.center
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setup() {
        self.tintColor = UIColor.init(hexString: "#DD2B2C")
    }

    func showIndicator() {
        startAnimating()
    }

    func hideIndicator() {
        stopAnimating()
    }
}