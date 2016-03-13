//
//  ToastView.swift
//  Om
//
//  Created by Naik, Parag Laxman (US - Mumbai) on 3/13/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import Foundation
import KSToastView

public class ToastView {

    class func ShowToast(toastMessage: String) {
        KSToastView.ks_setAppearanceCornerRadius(200)
        KSToastView.ks_showToast(toastMessage)
    }
}