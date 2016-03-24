//
//  DateSelectionViewController.swift
//  Om
//
//  Created by Vinita on 2/27/16.
//  Copyright © 2016 Vinita. All rights reserved.
//

import UIKit
import KSToastView
class DateSelectionViewController: UIViewController {
    @IBOutlet weak var containerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var calendarContainer: UIView!
    @IBOutlet weak var timeslotSegmentedControl: UISegmentedControl!

    var product: Product?

    enum Timeslot: String {
        case Morning = "Morning"
        case Afternoon = "Afternoon"
        case Evening = "Evening"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let calendar = CKCalendarView()
        self.calendarContainer.addSubview(calendar)
        calendar.delegate = self;
        self.containerHeightConstraint.constant = DeviceType.IS_IPHONE_6_OR_MORE ? 350 : 290
        initTimeslotSegmentedControl()
    }

    override func viewWillAppear(animated: Bool) {
        self.title = "Select Date"
    }
    
    @IBAction func nextButtonClicked(button: UIButton) {

        if (timeslotSegmentedControl.selectedSegmentIndex > -1) {
            let selectedTimeslotName = timeslotSegmentedControl.titleForSegmentAtIndex(timeslotSegmentedControl.selectedSegmentIndex)
            showVendorAvailability(Timeslot(rawValue: selectedTimeslotName!)!)
        } else {
            KSToastView.ks_showToast("Please select a time slot")
        }
    }

    func initTimeslotSegmentedControl() {
        if let selectedProduct = product {
            timeslotSegmentedControl.setEnabled(selectedProduct.morning, forSegmentAtIndex: 0)
            timeslotSegmentedControl.setEnabled(selectedProduct.afternoon, forSegmentAtIndex: 1)
            timeslotSegmentedControl.setEnabled(selectedProduct.evening, forSegmentAtIndex: 2)
        }
    }

    func showVendorAvailability(timeslot: Timeslot) {
        let vendorAvailabilityVC = self.storyboard?.instantiateViewControllerWithIdentifier("PanditSelectionViewController") as!
        PanditSelectionViewController
        UserSession.sharedInstance.newBooking?.slot = timeslot.rawValue
        self.navigationController?.pushViewController(vendorAvailabilityVC, animated: true)
    }
}

extension DateSelectionViewController : CKCalendarDelegate  {

    func calendar(calendar: CKCalendarView!, didSelectDate date: NSDate!) {
        UserSession.sharedInstance.newBooking?.book_date_NSDate = date
    }
}

